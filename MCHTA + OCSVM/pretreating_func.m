function new_data = pretreating_func(data,type)

switch type
    
    case 1   
        new_data = zscore(data);
        
    case 2           
        data_min = min(data);    
        data_max = max(xy_t);    
        new_data = bsxfun(@rdivide,bsxfun(@minus,data,data_min),(data_max - data_min));
        
    case 3            
        data_min = min(data);    
        data_max = max(data);    
        data_mean = mean(data);   
        new_data = bsxfun(@rdivide,bsxfun(@minus,data,data_mean),(data_max - data_min));
        
end
