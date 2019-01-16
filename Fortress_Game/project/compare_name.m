function result = compare_name(str)
fid=fopen('playerinfo.mat','r');
    if(fid>0)
        fclose(fid);
        load playerinfo.mat
     
        index=0; % Initial value    
        for k=1:length(player)
            if strcmp(player(k).name, str)
                index=k;
            end
        end
 
        if(index>0) %% Process if same name exists
            result = 1;
        else
            result=2;
        end
    else
        result=0;
    end

end