

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\11_11_2008\h

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

load myrois

win=8;

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_contour,1)
        z=z+1;
        eval(['coeff_contour_cond',int2str(i),'_pix_',int2str(roi_contour(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_contour(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_contour(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_contour(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_contour_cond',int2str(i),'_pix_',int2str(roi_contour(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_contour_cond',int2str(i),'=coeff_contour_cond',int2str(i),'_pix_',int2str(roi_contour(p)),';'])    
        else
            eval(['coeff_contour_cond',int2str(i),'=coeff_contour_cond',int2str(i),'+coeff_contour_cond',int2str(i),'_pix_',int2str(roi_contour(p)),';'])
        end 
        eval(['clear coeff_contour_cond',int2str(i),'_pix_',int2str(roi_contour(p))])
    end;
    eval(['coeff_contour_cond',int2str(i),'=coeff_contour_cond',int2str(i),'/size(roi_contour,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_contour_cond',int2str(i),' coeff_contour_cond',int2str(i),' roi_contour pixels'])
    cd ..
    eval(['clear coeff_contour_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_maskin,1)
        z=z+1;
        eval(['coeff_maskin_cond',int2str(i),'_pix_',int2str(roi_maskin(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_maskin(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_maskin(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_maskin(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_maskin_cond',int2str(i),'_pix_',int2str(roi_maskin(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_maskin_cond',int2str(i),'=coeff_maskin_cond',int2str(i),'_pix_',int2str(roi_maskin(p)),';'])    
        else
            eval(['coeff_maskin_cond',int2str(i),'=coeff_maskin_cond',int2str(i),'+coeff_maskin_cond',int2str(i),'_pix_',int2str(roi_maskin(p)),';'])
        end 
        eval(['clear coeff_maskin_cond',int2str(i),'_pix_',int2str(roi_maskin(p))])
    end;
    eval(['coeff_maskin_cond',int2str(i),'=coeff_maskin_cond',int2str(i),'/size(roi_maskin,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_maskin_cond',int2str(i),' coeff_maskin_cond',int2str(i),' roi_maskin pixels'])
    cd ..
    eval(['clear coeff_maskin_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\c\correct_and_incorrect_together

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

load myrois

win=8;

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle_diff,1)
        z=z+1;
        eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])    
        else
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'+coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])
        end 
        eval(['clear coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p))])
    end;
    eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'/size(roi_circle_diff,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_diff_cond',int2str(i),' coeff_circle_diff_cond',int2str(i),' roi_circle_diff pixels'])
    cd ..
    eval(['clear coeff_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])    
        else
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'+coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])
        end 
        eval(['clear coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p))])
    end;
    eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'/size(roi_bg_in,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end




cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\d\correct_and_incorrect_together

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

load myrois

win=8;

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle_diff,1)
        z=z+1;
        eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])    
        else
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'+coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])
        end 
        eval(['clear coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p))])
    end;
    eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'/size(roi_circle_diff,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_diff_cond',int2str(i),' coeff_circle_diff_cond',int2str(i),' roi_circle_diff pixels'])
    cd ..
    eval(['clear coeff_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])    
        else
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'+coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])
        end 
        eval(['clear coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p))])
    end;
    eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'/size(roi_bg_in,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end



cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_18\e\correct_and_incorrect_together

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

load myrois

win=8;

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle_diff,1)
        z=z+1;
        eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])    
        else
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'+coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])
        end 
        eval(['clear coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p))])
    end;
    eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'/size(roi_circle_diff,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_diff_cond',int2str(i),' coeff_circle_diff_cond',int2str(i),' roi_circle_diff pixels'])
    cd ..
    eval(['clear coeff_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])    
        else
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'+coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])
        end 
        eval(['clear coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p))])
    end;
    eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'/size(roi_bg_in,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end




cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\d\correct_and_incorrect_together

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

load myrois

win=8;

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle_diff,1)
        z=z+1;
        eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])    
        else
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'+coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])
        end 
        eval(['clear coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p))])
    end;
    eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'/size(roi_circle_diff,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_diff_cond',int2str(i),' coeff_circle_diff_cond',int2str(i),' roi_circle_diff pixels'])
    cd ..
    eval(['clear coeff_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])    
        else
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'+coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])
        end 
        eval(['clear coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p))])
    end;
    eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'/size(roi_bg_in,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end




cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\e\correct_and_incorrect_together

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

load myrois

win=8;

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle_diff,1)
        z=z+1;
        eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])    
        else
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'+coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])
        end 
        eval(['clear coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p))])
    end;
    eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'/size(roi_circle_diff,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_diff_cond',int2str(i),' coeff_circle_diff_cond',int2str(i),' roi_circle_diff pixels'])
    cd ..
    eval(['clear coeff_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])    
        else
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'+coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])
        end 
        eval(['clear coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p))])
    end;
    eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'/size(roi_bg_in,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_11_25\f\correct_and_incorrect_together

load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

load myrois

win=8;

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle_diff,1)
        z=z+1;
        eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])    
        else
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'+coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])
        end 
        eval(['clear coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p))])
    end;
    eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'/size(roi_circle_diff,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_diff_cond',int2str(i),' coeff_circle_diff_cond',int2str(i),' roi_circle_diff pixels'])
    cd ..
    eval(['clear coeff_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])    
        else
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'+coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])
        end 
        eval(['clear coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p))])
    end;
    eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'/size(roi_bg_in,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\d\correct_and_incorrect_together
load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

load myrois

win=8;

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle_diff,1)
        z=z+1;
        eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])    
        else
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'+coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])
        end 
        eval(['clear coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p))])
    end;
    eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'/size(roi_circle_diff,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_diff_cond',int2str(i),' coeff_circle_diff_cond',int2str(i),' roi_circle_diff pixels'])
    cd ..
    eval(['clear coeff_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])    
        else
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'+coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])
        end 
        eval(['clear coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p))])
    end;
    eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'/size(roi_bg_in,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\e\correct_and_incorrect_together
load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

load myrois

win=8;

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle_diff,1)
        z=z+1;
        eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])    
        else
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'+coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])
        end 
        eval(['clear coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p))])
    end;
    eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'/size(roi_circle_diff,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_diff_cond',int2str(i),' coeff_circle_diff_cond',int2str(i),' roi_circle_diff pixels'])
    cd ..
    eval(['clear coeff_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])    
        else
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'+coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])
        end 
        eval(['clear coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p))])
    end;
    eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'/size(roi_bg_in,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\psychophysics\2008_12_03\f\correct_and_incorrect_together
load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

load myrois

win=8;

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle_diff,1)
        z=z+1;
        eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])    
        else
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'+coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])
        end 
        eval(['clear coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p))])
    end;
    eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'/size(roi_circle_diff,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_diff_cond',int2str(i),' coeff_circle_diff_cond',int2str(i),' roi_circle_diff pixels'])
    cd ..
    eval(['clear coeff_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])    
        else
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'+coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])
        end 
        eval(['clear coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p))])
    end;
    eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'/size(roi_bg_in,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end


cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\e
load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

load myrois

win=8;

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle_diff,1)
        z=z+1;
        eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])    
        else
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'+coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])
        end 
        eval(['clear coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p))])
    end;
    eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'/size(roi_circle_diff,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_diff_cond',int2str(i),' coeff_circle_diff_cond',int2str(i),' roi_circle_diff pixels'])
    cd ..
    eval(['clear coeff_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])    
        else
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'+coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])
        end 
        eval(['clear coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p))])
    end;
    eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'/size(roi_bg_in,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end




cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\06_10_2008\f
load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

load myrois

win=8;

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle_diff,1)
        z=z+1;
        eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])    
        else
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'+coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])
        end 
        eval(['clear coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p))])
    end;
    eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'/size(roi_circle_diff,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_diff_cond',int2str(i),' coeff_circle_diff_cond',int2str(i),' roi_circle_diff pixels'])
    cd ..
    eval(['clear coeff_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])    
        else
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'+coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])
        end 
        eval(['clear coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p))])
    end;
    eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'/size(roi_bg_in,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\d
load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

load myrois

win=8;

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle_diff,1)
        z=z+1;
        eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])    
        else
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'+coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])
        end 
        eval(['clear coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p))])
    end;
    eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'/size(roi_circle_diff,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_diff_cond',int2str(i),' coeff_circle_diff_cond',int2str(i),' roi_circle_diff pixels'])
    cd ..
    eval(['clear coeff_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])    
        else
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'+coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])
        end 
        eval(['clear coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p))])
    end;
    eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'/size(roi_bg_in,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

cd F:\Data\VSDI\Contour_integration\legolas\right_hemisphere\22_10_2008\e
load pixels_to_remove
t=ones(10000,1);
t(pixels_to_remove)=0;
pixels=find(t);
clear t

load myrois

win=8;

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_circle_diff,1)
        z=z+1;
        eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_circle_diff(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])    
        else
            eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'+coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p)),';'])
        end 
        eval(['clear coeff_circle_diff_cond',int2str(i),'_pix_',int2str(roi_circle_diff(p))])
    end;
    eval(['coeff_circle_diff_cond',int2str(i),'=coeff_circle_diff_cond',int2str(i),'/size(roi_circle_diff,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_circle_diff_cond',int2str(i),' coeff_circle_diff_cond',int2str(i),' roi_circle_diff pixels'])
    cd ..
    eval(['clear coeff_circle_diff_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end

for i=[1 2 4 5] %condition count
    z=0;
    eval(['load cond',int2str(i),'n_dt_bl'])
    a=1;    
    eval(['b=size(cond',int2str(i),'n_dt_bl,2)/2;'])
    for p=1:size(roi_bg_in,1)
        z=z+1;
        eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'=NaN*ones(size(pixels,1),b-win,a);'])
        for h=1:a  %trial count
            
            
            disp(['pixel #',int2str(p),' condition #',int2str(i),' trial #',int2str(h),' transforming data'])
            %eval(['load cond',int2str(i),'n_dt_bl'])
            eval(['cond',int2str(i),'n_dt_tr=mean(cond',int2str(i),'n_dt_bl(:,2:end,:),3);'])
            
                for j=1:(b-win)
                   eval(['cc=sum((repmat(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),[size(pixels,1) 1])-repmat(mean(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),2),[size(pixels,1) win])).*(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1)-repmat(mean(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),2),[1 win])),2)/(win-1);'])
                   eval(['var1=repmat(std(cond',int2str(i),'n_dt_tr(roi_bg_in(p),j:j+win-1),0,2).^2,[size(pixels,1) 1]);'])
                   eval(['var2=std(cond',int2str(i),'n_dt_tr(pixels,j:j+win-1),0,2).^2;'])
                   eval(['coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),'(:,j,h)=cc./sqrt(var1.*var2);']) 
                end;
            
        end;
        if z==1
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])    
        else
            eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'+coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p)),';'])
        end 
        eval(['clear coeff_bg_in_cond',int2str(i),'_pix_',int2str(roi_bg_in(p))])
    end;
    eval(['coeff_bg_in_cond',int2str(i),'=coeff_bg_in_cond',int2str(i),'/size(roi_bg_in,1);'])
    mkdir signal_corr
    cd signal_corr
    eval(['save coeff_bg_in_cond',int2str(i),' coeff_bg_in_cond',int2str(i),' roi_bg_in pixels'])
    cd ..
    eval(['clear coeff_bg_in_cond',int2str(i)])
    eval(['clear cond',int2str(i),'n_dt_bl'])            
end






