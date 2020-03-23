%df_class = readtable('wins.csv');
%{
qrtrs=unique(df_class(:,'Date'),'stable');
qrtrs = table2array(qrtrs);
qrtrs = sortrows(qrtrs);

df_now = containers.Map;     %Stores all data entries for the specific month currently iterated over 
returns=containers.Map;      %Holds individual monthly returns for all stocks through 1987-2011
returns_1 = containers.Map;  %Overvalued stock returns
returns_2 = containers.Map;  %2nd quintile...
returns_3 = containers.Map;
returns_4 = containers.Map;
returns_5 = containers.Map;

pr_returns_1 = containers.Map;  
pr_returns_2 = containers.Map;  
pr_returns_3 = containers.Map;
pr_returns_4 = containers.Map;
pr_returns_5 = containers.Map;

yr_returns_1 = containers.Map;  %Overvalued stock returns
yr_returns_2 = containers.Map; %2nd quintile...
yr_returns_3 = containers.Map;
yr_returns_4 = containers.Map;
yr_returns_5 = containers.Map;

fo_yr_returns_1 = containers.Map;  %Overvalued stock returns
fo_yr_returns_2 = containers.Map;  
fo_yr_returns_3 = containers.Map;
fo_yr_returns_4 = containers.Map;
fo_yr_returns_5 = containers.Map;
portfolio = containers.Map;

cus_list = containers.Map;

features = {'CurrentAssets_Other_Total','Assets_Other_Total','AccountPayable_Creditors_Trade','Assets_Total','Common_OrdinaryEquity_Total','CashAndShort_TermInvestments','Long_TermDebt_Total','DiscontinuedOperations','Dividends_Preferred_Preference','IncomeBeforeExtraordinaryItems_AdjustedForCommonStockEquivalent','IncomeBeforeExtraordinaryItems_AvailableForCommon','IncomeBeforeExtraordinaryItems','InvestedCapital_Total_Quarterly','CurrentLiabilities_Other_Total','Liabilities_Other','Liabilities_Total','NetIncome_Loss_','Non_OperatingIncome_Expense__Total','PretaxIncome','PropertyPlantAndEquipment_Total_Net_','Preferred_PreferenceStock_Capital__Total','Preferred_PreferenceStock_Redeemable','Sales_Turnover_Net_','StockholdersEquity_Parent_IndexFundamental_Quarterly','StockholdersEquity_Total','IncomeTaxes_Total','ExtraordinaryItemsAndDiscontinuedOperations','CashDividends'};


m=0;

for i=62:length(qrtrs)
    tic
    
    % Initial all relevent dataframes. One for each month from this one to
    % 60 months ago.  Indexed from 0 being this month to 60 being 60 months
    % ago.
    df_now('0')= df_class(df_class.Date==qrtrs(i),:);
    for k=1:12
        df_now(string(k)) = df_class(df_class.Date==qrtrs(i-k),:);
        temp = df_now(string(k));
        cus_list(string(k)) = table2array(temp(:,'CUSIP')); %list off all stocks in this month by cusip number
        
        % Create a list containing stocks that showed up in all of previous
        % 10 months
        if k==1
                ten_sh_cus = cus_list('1');
        else
                ten_sh_cus = intersect(ten_sh_cus, cus_list(string(k)));
        end
    end
    
    for k=12:60
        df_now(string(k)) = df_class(df_class.Date==qrtrs(i-k),:);
        cus_list(string(k)) = table2array(temp(:,'CUSIP'));
        
        % Create a list containing stocks that showed up in all of between
        % 12 and 60 months ago
        if k==12
            four_sh_cus = cus_list('12');
        else
            four_sh_cus = intersect(four_sh_cus, cus_list(string(k)));
        end
    end
    
    % Caculate returns from last month's porfolio
    if m>0
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     Portfolio 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        port = portfolio('1'); % Temporary array to hold portfolio 1 from previous month
        port=table2array(port);
        
        %%%%%%%   Returns from last month  ########
        df_0 = df_now('0');
        return_array=[];     % Temporary array to hold returns from previous month      
        for j=1:length(port)
            cus=port(j); % Cusip of current stock being considered
            cus=[cus{:}]; % Need to convert cell to string
            row = df_0(string(df_0.CUSIP)==cus, :);  % row from current month for the stock being considered
            ret = row.Returns;      % Pick of the value for Returns
            ret = [ret{:}];      % Need to convert cell value to string.  Some return str so cannot yet convert to double
            if strcmp(ret,"C")==0
                ret = str2double(ret);
                return_array=[return_array ret];
            end
        end
        returns_1(num2str(i))=return_array;
 
    
        %%%%%%%   Returns from 2 months ago to last month  ########
        df_1 = df_now('1');
        return_array=[];     % Temporary array to hold returns from previous month      
        for j=1:length(port)
            cus=port(j); % Cusip of current stock being considered
            cus=[cus{:}]; % Need to convert cell to string
            row = df_1(string(df_1.CUSIP)==cus, :);  % row from current month for the stock being considered
            ret = row.Returns;      % Pick of the value for Returns
            ret = [ret{:}];      % Need to convert cell value to string.  Some return str so cannot yet convert to double
            if strcmp(ret,"C")==0
                ret = str2double(ret);
                return_array=[return_array ret];
            end
        end
        pr_returns_1(num2str(i))=return_array;
       
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     Portfolio 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        port = portfolio('2'); % Temporary array to hold portfolio 1 from previous month
        port=table2array(port);
        
        %%%%%%%   Returns from last month  ########
        df_0 = df_now('0');
        return_array=[];     % Temporary array to hold returns from previous month      
        for j=1:length(port)
            cus=port(j); % Cusip of current stock being considered
            cus=[cus{:}]; % Need to convert cell to string
            row = df_0(string(df_0.CUSIP)==cus, :);  % row from current month for the stock being considered
            ret = row.Returns;      % Pick of the value for Returns
            ret = [ret{:}];      % Need to convert cell value to string.  Some return str so cannot yet convert to double
            if strcmp(ret,"C")==0
                ret = str2double(ret);
                return_array=[return_array ret];
            end
        end
        returns_2(num2str(i))=return_array;
 
    
        %%%%%%%   Returns from 2 months ago to last month  ########
        df_1 = df_now('2');
        return_array=[];     % Temporary array to hold returns from previous month      
        for j=1:length(port)
            cus=port(j); % Cusip of current stock being considered
            cus=[cus{:}]; % Need to convert cell to string
            row = df_1(string(df_1.CUSIP)==cus, :);  % row from current month for the stock being considered
            ret = row.Returns;      % Pick of the value for Returns
            ret = [ret{:}];      % Need to convert cell value to string.  Some return str so cannot yet convert to double
            if strcmp(ret,"C")==0
                ret = str2double(ret);
                return_array=[return_array ret];
            end
        end
        pr_returns_2(num2str(i))=return_array;
        
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     Portfolio 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        port = portfolio('3'); % Temporary array to hold portfolio 1 from previous month
        port=table2array(port);
        
        %%%%%%%   Returns from last month  ########
        df_0 = df_now('0');
        return_array=[];     % Temporary array to hold returns from previous month      
        for j=1:length(port)
            cus=port(j); % Cusip of current stock being considered
            cus=[cus{:}]; % Need to convert cell to string
            row = df_0(string(df_0.CUSIP)==cus, :);  % row from current month for the stock being considered
            ret = row.Returns;      % Pick of the value for Returns
            ret = [ret{:}];      % Need to convert cell value to string.  Some return str so cannot yet convert to double
            if strcmp(ret,"C")==0
                ret = str2double(ret);
                return_array=[return_array ret];
            end
        end
        returns_3(num2str(i))=return_array;
 
    
        %%%%%%%   Returns from 2 months ago to last month  ########
        df_1 = df_now('1');
        return_array=[];     % Temporary array to hold returns from previous month      
        for j=1:length(port)
            cus=port(j); % Cusip of current stock being considered
            cus=[cus{:}]; % Need to convert cell to string
            row = df_1(string(df_1.CUSIP)==cus, :);  % row from current month for the stock being considered
            ret = row.Returns;      % Pick of the value for Returns
            ret = [ret{:}];      % Need to convert cell value to string.  Some return str so cannot yet convert to double
            if strcmp(ret,"C")==0
                ret = str2double(ret);
                return_array=[return_array ret];
            end
        end
        pr_returns_3(num2str(i))=return_array;
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     Portfolio 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        port = portfolio('4'); % Temporary array to hold portfolio 1 from previous month
        port=table2array(port);
        
        %%%%%%%   Returns from last month  ########
        df_0 = df_now('0');
        return_array=[];     % Temporary array to hold returns from previous month      
        for j=1:length(port)
            cus=port(j); % Cusip of current stock being considered
            cus=[cus{:}]; % Need to convert cell to string
            row = df_0(string(df_0.CUSIP)==cus, :);  % row from current month for the stock being considered
            ret = row.Returns;      % Pick of the value for Returns
            ret = [ret{:}];      % Need to convert cell value to string.  Some return str so cannot yet convert to double
            if strcmp(ret,"C")==0
                ret = str2double(ret);
                return_array=[return_array ret];
            end
        end
        returns_4(num2str(i))=return_array;
 
    
        %%%%%%%   Returns from 2 months ago to last month  ########
        df_1 = df_now('1');
        return_array=[];     % Temporary array to hold returns from previous month      
        for j=1:length(port)
            cus=port(j); % Cusip of current stock being considered
            cus=[cus{:}]; % Need to convert cell to string
            row = df_1(string(df_1.CUSIP)==cus, :);  % row from current month for the stock being considered
            ret = row.Returns;      % Pick of the value for Returns
            ret = [ret{:}];      % Need to convert cell value to string.  Some return str so cannot yet convert to double
            if strcmp(ret,"C")==0
                ret = str2double(ret);
                return_array=[return_array ret];
            end
        end
        pr_returns_4(num2str(i))=return_array;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     Portfolio 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        port = portfolio('5'); % Temporary array to hold portfolio 1 from previous month
        port=table2array(port);
        
        %%%%%%%   Returns from last month  ########
        df_0 = df_now('0');
        return_array=[];     % Temporary array to hold returns from previous month      
        for j=1:length(port)
            cus=port(j); % Cusip of current stock being considered
            cus=[cus{:}]; % Need to convert cell to string
            row = df_0(string(df_0.CUSIP)==cus, :);  % row from current month for the stock being considered
            ret = row.Returns;      % Pick of the value for Returns
            ret = [ret{:}];      % Need to convert cell value to string.  Some return str so cannot yet convert to double
            if strcmp(ret,"C")==0
                ret = str2double(ret);
                if num2str(ret)=="NaN"
                    row.Returns
                end
                return_array=[return_array ret];
            end
        end
        returns_5(num2str(i))=return_array;
 
    
        %%%%%%%   Returns from 2 months ago to last month  ########
        df_1 = df_now('1');
        return_array=[];     % Temporary array to hold returns from previous month      
        for j=1:length(port)
            cus=port(j); % Cusip of current stock being considered
            cus=[cus{:}]; % Need to convert cell to string
            row = df_1(string(df_1.CUSIP)==cus, :);  % row from current month for the stock being considered
            ret = row.Returns;      % Pick of the value for Returns
            ret = [ret{:}];      % Need to convert cell value to string.  Some return str so cannot yet convert to double
            if strcmp(ret,"C")==0
                ret = str2double(ret);
                return_array=[return_array ret];
            end
        end
        pr_returns_5(num2str(i))=return_array;
        
       
    end

  
               
    
    % Run Model on all of current months data to get a fit
    temp = df_now(string(1));   %Extract feature variable data
    X = table2array(temp(:,features));
    X = fillmissing(X,'constant',0);

    temp = df_now('1');
    Y = table2array(temp(:,'Price'));   %Extract target data
    %Y = str2double(Y);

    mdl = fitrlinear(X,Y);  %Model is not fitted to this months data
    
    ypred = predict(mdl,X);
    perc_dif = (ypred-Y)./Y;
    
    cusandperc = [temp(:,'CUSIP') array2table(perc_dif)];
    srted = sortrows(cusandperc,'perc_dif');
    q = round(length(ypred)/5);
    
    portfolio('1') = srted(1:q,'CUSIP');
    portfolio('2') = srted(q:2*q,'CUSIP');
    portfolio('3') = srted(2*q:3*q,'CUSIP');
    portfolio('4') = srted(3*q:4*q,'CUSIP');
    portfolio('5') = srted(4*q:length(ypred),'CUSIP');
    
    m=m+1;
    
    toc
    
    
end

%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%  Calculate Averages and Returns %%%%%%%%%%%%%%%%%%%%%%%
total_ret_0=[1];  
total_ret_1=[1];  
total_ret_2=[1];
total_ret_3=[1];
total_ret_4=[1];
total_ret_5=[1];  
avg_ret_0=[];
avg_ret_1=[];
avg_ret_2=[];
avg_ret_3=[];
avg_ret_4=[];
avg_ret_5=[];
i=63;

for j=1:length(returns_1)
    avg_ret_1 = [avg_ret_1 mean(rmmissing(returns_1(num2str(i))))];
    total_ret_1 = [total_ret_1 (1+avg_ret_1(j))*total_ret_1(j)];
    
    avg_ret_2 = [avg_ret_2 mean(rmmissing(returns_2(num2str(i))))];
    total_ret_2 = [total_ret_2 (1+avg_ret_2(j))*total_ret_2(j)];
    
    avg_ret_3 = [avg_ret_3 mean(rmmissing(returns_3(num2str(i))))];
    total_ret_3 = [total_ret_3 (1+avg_ret_3(j))*total_ret_3(j)];
    
    avg_ret_4 = [avg_ret_4 mean(rmmissing(returns_4(num2str(i))))];
    total_ret_4 = [total_ret_4 (1+avg_ret_4(j))*total_ret_1(j)];
    
    avg_ret_5 = [avg_ret_5 mean(rmmissing(returns_5(num2str(i))))];
    total_ret_5 = [total_ret_5 (1+avg_ret_5(j))*total_ret_5(j)];
    
    avg_ret_0 = [avg_ret_0 mean([avg_ret_1(j) avg_ret_2(j) avg_ret_3(j) avg_ret_4(j) avg_ret_5(j)])];
    total_ret_0 = [total_ret_0 (1+avg_ret_0(j))*total_ret_0(j)];
    i=i+1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%  Previous Month Returns %%%%%%%%%%%%%%%%%%%%%%%
pr_total_ret_0=[1]; 
pr_total_ret_1=[1];  
pr_total_ret_2=[1];
pr_total_ret_3=[1];
pr_total_ret_4=[1];
pr_total_ret_5=[1];
pr_avg_ret_0=[];
pr_avg_ret_1=[];
pr_avg_ret_2=[];
pr_avg_ret_3=[];
pr_avg_ret_4=[];
pr_avg_ret_5=[];
i=63;

for j=1:length(returns_1)
    pr_avg_ret_1 = [pr_avg_ret_1 mean(rmmissing(pr_returns_1(num2str(i))))];
    pr_total_ret_1 = [pr_total_ret_1 (1+pr_avg_ret_1(j))*pr_total_ret_1(j)];
    
    pr_avg_ret_2 = [pr_avg_ret_2 mean(rmmissing(pr_returns_2(num2str(i))))];
    pr_total_ret_2 = [pr_total_ret_2 (1+pr_avg_ret_2(j))*pr_total_ret_2(j)];
    
    pr_avg_ret_3 = [pr_avg_ret_3 mean(rmmissing(pr_returns_3(num2str(i))))];
    pr_total_ret_3 = [pr_total_ret_3 (1+pr_avg_ret_3(j))*pr_total_ret_3(j)];
    
    pr_avg_ret_4 = [pr_avg_ret_4 mean(rmmissing(pr_returns_4(num2str(i))))];
    pr_total_ret_4 = [pr_total_ret_4 (1+pr_avg_ret_4(j))*pr_total_ret_1(j)];
    
    pr_avg_ret_5 = [pr_avg_ret_5 mean(rmmissing(pr_returns_5(num2str(i))))];
    pr_total_ret_5 = [pr_total_ret_5 (1+pr_avg_ret_5(j))*pr_total_ret_5(j)];
    
    pr_avg_ret_0 = [pr_avg_ret_0 mean([pr_avg_ret_1(j) pr_avg_ret_2(j) pr_avg_ret_3(j) pr_avg_ret_4(j) pr_avg_ret_5(j)])];
    pr_total_ret_0 = [pr_total_ret_0 (1+pr_avg_ret_0(j))*pr_total_ret_0(j)];
    i=i+1;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%  10 Month Returns %%%%%%%%%%%%%%%%%%%%%%%

yr_total_ret_0=[1];  
yr_total_ret_1=[1];  
yr_total_ret_2=[1];
yr_total_ret_3=[1];
yr_total_ret_4=[1];
yr_total_ret_5=[1];  
yr_avg_ret_0=[];
yr_avg_ret_1=[];
yr_avg_ret_2=[];
yr_avg_ret_3=[];
yr_avg_ret_4=[];
yr_avg_ret_5=[];
i=63;

for j=1:length(returns_1)
    yr_avg_ret_1 = [yr_avg_ret_1 mean(rmmissing(yr_returns_1(num2str(i))))];
    total_ret_1 = [yr_total_ret_1 (1+yr_avg_ret_1(j))*yr_total_ret_1(j)];
    
    yr_avg_ret_2 = [yr_avg_ret_2 mean(rmmissing(yr_returns_2(num2str(i))))];
    yr_total_ret_2 = [yr_total_ret_2 (1+yr_avg_ret_2(j))*yr_total_ret_2(j)];
    
    yr_avg_ret_3 = [yr_avg_ret_3 mean(rmmissing(yr_returns_3(num2str(i))))];
    yr_total_ret_3 = [yr_total_ret_3 (1+yr_avg_ret_3(j))*yr_total_ret_3(j)];
    
    yr_avg_ret_4 = [yr_avg_ret_4 mean(rmmissing(yr_returns_4(num2str(i))))];
    total_ret_4 = [yr_total_ret_4 (1+yr_avg_ret_4(j))*yr_total_ret_1(j)];
    
    yr_avg_ret_5 = [yr_avg_ret_5 mean(rmmissing(yr_returns_5(num2str(i))))];
    yr_total_ret_5 = [yr_total_ret_5 (1+yr_avg_ret_5(j))*yr_total_ret_5(j)];
    
    yr_avg_ret_0 = [yr_avg_ret_0 mean([yr_avg_ret_1(j) yr_avg_ret_2(j) yr_avg_ret_3(j) yr_avg_ret_4(j) yr_avg_ret_5(j)])];
    yr_total_ret_0 = [yr_total_ret_0 (1+yr_avg_ret_0(j))*yr_total_ret_0(j)];
    i=i+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%  4 Year Returns %%%%%%%%%%%%%%%%%%%%%%%
fo_total_ret_0=[1];  
fo_total_ret_1=[1];  
fo_total_ret_2=[1];
fo_total_ret_3=[1];
fo_total_ret_4=[1];
fo_total_ret_5=[1];  
fo_avg_ret_0=[];
fo_avg_ret_1=[];
fo_avg_ret_2=[];
fo_avg_ret_3=[];
fo_avg_ret_4=[];
fo_avg_ret_5=[];
i=63;

for j=1:length(returns_1)
    fo_avg_ret_1 = [fo_avg_ret_1 mean(rmmissing(fo_returns_1(num2str(i))))];
    fo_total_ret_1 = [fo_total_ret_1 (1+fo_avg_ret_1(j))*fo_total_ret_1(j)];
    
    fo_avg_ret_2 = [fo_avg_ret_2 mean(rmmissing(fo_returns_2(num2str(i))))];
    fo_total_ret_2 = [fo_total_ret_2 (1+fo_avg_ret_2(j))*fo_total_ret_2(j)];
    
    fo_avg_ret_3 = [fo_avg_ret_3 mean(rmmissing(fo_returns_3(num2str(i))))];
    fo_total_ret_3 = [fo_total_ret_3 (1+fo_avg_ret_3(j))*fo_total_ret_3(j)];
    
    fo_avg_ret_4 = [fo_avg_ret_4 mean(rmmissing(fo_returns_4(num2str(i))))];
    fo_total_ret_4 = [fo_total_ret_4 (1+fo_avg_ret_4(j))*fo_total_ret_1(j)];
    
    fo_avg_ret_5 = [fo_avg_ret_5 mean(rmmissing(fo_returns_5(num2str(i))))];
    fo_total_ret_5 = [fo_total_ret_5 (1+fo_avg_ret_5(j))*fo_total_ret_5(j)];
    
    fo_avg_ret_0 = [fo_avg_ret_0 mean([fo_avg_ret_1(j) fo_avg_ret_2(j) fo_avg_ret_3(j) fo_avg_ret_4(j) fo_avg_ret_5(j)])];
    fo_total_ret_0 = [fo_total_ret_0 (1+fo_avg_ret_0(j))*fo_total_ret_0(j)];
    i=i+1;
end
   
