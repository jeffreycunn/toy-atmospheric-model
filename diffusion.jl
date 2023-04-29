#this code contained functions from mathlab so i added julia friendly functions
function diffusion!(varp, varm, varb, cmixh, cmixv, dx, dz, dt, nx, nz)
  # Horizontal Diffusion
  kmixh = cmixh * dx^2 / dt
  @inbounds for k = 2:nz-1
      @inbounds for i = 2:nx-1
          varp[i,k] += 2.0 * dt * kmixh * (varm[i+1,k] - 2.0 * varm[i,k] + varm[i-1,k]) / dx^2
      end
  end

  # Vertical Diffusion
  kmixv = cmixv * dz^2 / dt
  @inbounds for k = 3:nz-1
      @inbounds for i = 2:nx-1
          varp[i,k] += 2.0 * dt * kmixv * ((varm[i,k+1] - varb[k+1])
                                           - 2.0 * (varm[i,k] - varb[k])
                                           + (varm[i,k-1] - varb[k-1])) / dz^2
      end
  end
end
#= Note that I've made the following changes:

Added a ! to the function name to indicate that it modifies its input variables in place.
Removed the output variables varp and varm from the function signature since they are modified in place.
Used Julia's @inbounds macro to indicate that it's safe to use indices that are out of bounds, in order to potentially improve performance.=#