% calculate additional measures
gamma = nan(length(a), 1);
Rt = nan(length(a), 1);
lambda = nan(length(a), 1);
doubling_time = nan(length(a), 1);


for i = 1:length(a)
    gamma(i) = k.gammamax*a(i)/(k.Kgamma + a(i));
    Rt(i) = cr(i) + ct(i)+ cm(i) + cq(i) + cg(i);
    lambda(i) = gamma(i)*Rt(i)/k.M;
    doubling_time(i) = log(2)/lambda(i);
end

mean_lambda = sum(lambda)/length(lambda);
mean_doubling_time = sum(doubling_time)/length(doubling_time);