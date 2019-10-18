clear
load test21.mat
maxQr=max(max(qrain_2400))
maxQc=max(max(qc_2400))
total_qrain=sum(sum(qrain_2400>0.00001));
qrain_area = total_qrain*.25^2
total_qc=sum(sum(qc_2400>0.0001));
qc_area = total_qc*.25^2
