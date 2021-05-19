function [new_xy,opts] = xy_pretreating_func(xy,type1,type2,opts)

flag = 0;
if exist('opts','var')
    flag = 1;
end

switch type1
   
    case 11
        xy_t =log10(xy);
    case 12
        xy_t = log2(xy);
    case 13
        xy_t = log(xy);
    case 21
        xy_t = xy;
    case 22
        xy_t = 10^(-1) * xy;
    case 23
        xy_t = 10^(-2) * xy;
    case 24
        xy_t = 10^(-3) * xy;
    case 25
        xy_t = 10^(-4) * xy;
    case 26
        xy_t = 10^(-5) * xy;
    case 27
        xy_t = 10^(-6) * xy;
    case 28
        xy_t = 10^(-7) * xy;
    case 29
        xy_t = xy/180;
end

switch type2
    
    case 1    
        if flag == 0
            [new_xy,mu,sigma] = zscore(xy_t);
            opts.mu = mu;
            opts.sigma = sigma;
        else
            new_xy = bsxfun(@rdivide,bsxfun(@minus,xy_t,opts.mu),opts.sigma);
        end
        
    case 2    
        if flag == 0
            xy_min = min(xy_t);   
            xy_max = max(xy_t);   
            new_xy = bsxfun(@rdivide,bsxfun(@minus,xy_t,xy_min),(xy_max - xy_min));
            opts.min = xy_min;
            opts.max = xy_max;
        else
            new_xy = bsxfun(@rdivide,bsxfun(@minus,xy_t,opts.min),(opts.max - opts.min));
        end
        
    case 3    
        if flsg == 0
            xy_min = min(xy_t);   
            xy_max = max(xy_t);    
            xy_mean = mean(xy_t);    
            new_xy = bsxfun(@rdivide,bsxfun(@minus,xy_t,xy_mean),(xy_max - xy_min));
            opts.min = xy_min;
            opts.max = xy_max;
            opts.mean = xy_mean;
        else
            new_xy = bsxfun(@rdivide,bsxfun(@minus,xy_t,opts.mean),(opts.max - opts.min));
        end
        
end
