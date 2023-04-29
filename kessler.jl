function kessler(n::Int, qvp::Matrix{Float64}, qvtot::Matrix{Float64},
  qcp::Matrix{Float64}, qrainp::Matrix{Float64}, dt::Float64,
  qc0::Float64, k1::Float64, k2::Float64, cp::Float64,
  rd::Float64, lv::Float64, p0::Float64, pib::Matrix{Float64},
  thp::Matrix{Float64}, pip::Matrix{Float64}, rhou::Vector{Float64},
  rhow::Vector{Float64}, tb::Vector{Float64}, qb::Vector{Float64},
  VT::Matrix{Float64}, nx::Int, nz::Int)

# Rain Water Conversions
for k in 2:nz-1, i in 2:nx-1
autodt = 0.0
accrdt = 0.0
revapdt = 0.0

# AUTOCONVERSION OF CLOUD TO RAIN
if qcp[i,k] > 0.0
auto = k1 * max(qcp[i,k] - qc0, 0.0)
autodt = auto * 2 * dt
end

# ACCRETION OF CLOUD BY RAIN
if qcp[i,k] > 0.0 && qrainp[i,k] > 0.0
accr = rhou[k] * k2 * qcp[i,k] * qrainp[i,k]^0.875
accrdt = accr * 2 * dt
end

# limit amount of cloud water we can lose
if autodt + accrdt > qcp[i,k]
qcsink = autodt + accrdt
autodt = qcp[i,k] * autodt / qcsink
accrdt = qcp[i,k] * accrdt / qcsink
end

# EVAPORATION OF RAIN
if qrainp[i,k] > 0.0
cvent = 1.6 + 30.39 * (rhou[k] * qrainp[i,k])^0.2046
pprime = pip[i,k] * cp * rhou[k] * tb[k]
pbar = p0 * pib[k]^(cp / rd)
pres = pbar + pprime
temp = (thp[i,k] + tb[k]) * (pip[i,k] + pib[k])
# Teten's formula
qvsat = (380.0 / pres) * exp((17.27 * (temp - 273.0)) / (temp - 36.0))

if qvsat > qb[k] + qvp[i,k]
revap = cvent * (1.0 - ((qvp[i,k] + qb[k]) / qvsat)) *
    (rhou[k] * qrainp[i,k])^0.525 / ((2.03e4 + 9.584e6 / (qvsat * pres)) * rhou[k])

# limit amount of rain we can evaporate
revapdt = min(revap * 2 * dt, qrainp[i,k])
if (qvp[i,k] + qb[k] + revapdt)
