cd D:\intrinsic\20150123\a\Matt_files
load('cond_100_ave_clean_norm_response.mat')
load('cond_1200_ave_clean_norm_response.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave,205*205,180);
d2=reshape(cond_1200_ave,205*205,180);

GA_100_del1100_s1=nanmean(d(roi_s1,:),1)';
GA_100_del1100_s2=nanmean(d(roi_s2,:),1)';
GA_100_del1100_m1=nanmean(d(roi_m1,:),1)';
GA_100_del1100_a1=nanmean(d(roi_a1,:),1)';
GA_100_del1100_alm=nanmean(d(roi_alm,:),1)';
GA_100_del1100_m2=nanmean(d(roi_m2,:),1)';

GA_1200_del1100_s1=nanmean(d2(roi_s1,:),1)';
GA_1200_del1100_s2=nanmean(d2(roi_s2,:),1)';
GA_1200_del1100_m1=nanmean(d2(roi_m1,:),1)';
GA_1200_del1100_a1=nanmean(d2(roi_a1,:),1)';
GA_1200_del1100_alm=nanmean(d2(roi_alm,:),1)';
GA_1200_del1100_m2=nanmean(d2(roi_m2,:),1)';


cd D:\intrinsic\20150127\b\Matt_files
load('cond_100_ave_clean_norm_response.mat')
load('cond_1200_ave_clean_norm_response.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave,205*205,180);
d2=reshape(cond_1200_ave,205*205,180);

GA_100_del1100_s1=cat(2,GA_100_del1100_s1,nanmean(d(roi_s1,:),1)');
GA_100_del1100_s2=cat(2,GA_100_del1100_s2,nanmean(d(roi_s2,:),1)');
GA_100_del1100_m1=cat(2,GA_100_del1100_m1,nanmean(d(roi_m1,:),1)');
GA_100_del1100_a1=cat(2,GA_100_del1100_a1,nanmean(d(roi_a1,:),1)');
GA_100_del1100_alm=cat(2,GA_100_del1100_alm,nanmean(d(roi_alm,:),1)');
GA_100_del1100_m2=cat(2,GA_100_del1100_m2,nanmean(d(roi_m2,:),1)');

GA_1200_del1100_s1=cat(2,GA_1200_del1100_s1,nanmean(d2(roi_s1,:),1)');
GA_1200_del1100_s2=cat(2,GA_1200_del1100_s2,nanmean(d2(roi_s2,:),1)');
GA_1200_del1100_m1=cat(2,GA_1200_del1100_m1,nanmean(d2(roi_m1,:),1)');
GA_1200_del1100_a1=cat(2,GA_1200_del1100_a1,nanmean(d2(roi_a1,:),1)');
GA_1200_del1100_alm=cat(2,GA_1200_del1100_alm,nanmean(d2(roi_alm,:),1)');
GA_1200_del1100_m2=cat(2,GA_1200_del1100_m2,nanmean(d2(roi_m2,:),1)');

cd D:\intrinsic\20150127\d\Matt_files
load('cond_100_ave_clean_norm_response.mat')
load('cond_1200_ave_clean_norm_response.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave,205*205,180);
d2=reshape(cond_1200_ave,205*205,180);

GA_100_del1100_s1=cat(2,GA_100_del1100_s1,nanmean(d(roi_s1,:),1)');
GA_100_del1100_s2=cat(2,GA_100_del1100_s2,nanmean(d(roi_s2,:),1)');
GA_100_del1100_m1=cat(2,GA_100_del1100_m1,nanmean(d(roi_m1,:),1)');
GA_100_del1100_a1=cat(2,GA_100_del1100_a1,nanmean(d(roi_a1,:),1)');
GA_100_del1100_alm=cat(2,GA_100_del1100_alm,nanmean(d(roi_alm,:),1)');
GA_100_del1100_m2=cat(2,GA_100_del1100_m2,nanmean(d(roi_m2,:),1)');

GA_1200_del1100_s1=cat(2,GA_1200_del1100_s1,nanmean(d2(roi_s1,:),1)');
GA_1200_del1100_s2=cat(2,GA_1200_del1100_s2,nanmean(d2(roi_s2,:),1)');
GA_1200_del1100_m1=cat(2,GA_1200_del1100_m1,nanmean(d2(roi_m1,:),1)');
GA_1200_del1100_a1=cat(2,GA_1200_del1100_a1,nanmean(d2(roi_a1,:),1)');
GA_1200_del1100_alm=cat(2,GA_1200_del1100_alm,nanmean(d2(roi_alm,:),1)');
GA_1200_del1100_m2=cat(2,GA_1200_del1100_m2,nanmean(d2(roi_m2,:),1)');


cd D:\intrinsic\20150128\a\Matt_files
load('cond_100_ave_clean_norm_response.mat')
load('cond_1200_ave_clean_norm_response.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave,205*205,180);
d2=reshape(cond_1200_ave,205*205,180);

GA_100_del1100_s1=cat(2,GA_100_del1100_s1,nanmean(d(roi_s1,:),1)');
GA_100_del1100_s2=cat(2,GA_100_del1100_s2,nanmean(d(roi_s2,:),1)');
GA_100_del1100_m1=cat(2,GA_100_del1100_m1,nanmean(d(roi_m1,:),1)');
GA_100_del1100_a1=cat(2,GA_100_del1100_a1,nanmean(d(roi_a1,:),1)');
GA_100_del1100_alm=cat(2,GA_100_del1100_alm,nanmean(d(roi_alm,:),1)');
GA_100_del1100_m2=cat(2,GA_100_del1100_m2,nanmean(d(roi_m2,:),1)');

GA_1200_del1100_s1=cat(2,GA_1200_del1100_s1,nanmean(d2(roi_s1,:),1)');
GA_1200_del1100_s2=cat(2,GA_1200_del1100_s2,nanmean(d2(roi_s2,:),1)');
GA_1200_del1100_m1=cat(2,GA_1200_del1100_m1,nanmean(d2(roi_m1,:),1)');
GA_1200_del1100_a1=cat(2,GA_1200_del1100_a1,nanmean(d2(roi_a1,:),1)');
GA_1200_del1100_alm=cat(2,GA_1200_del1100_alm,nanmean(d2(roi_alm,:),1)');
GA_1200_del1100_m2=cat(2,GA_1200_del1100_m2,nanmean(d2(roi_m2,:),1)');


cd D:\intrinsic\20150128\e\Matt_files
load('cond_100_ave_clean_norm_response.mat')
load('cond_1200_ave_clean_norm_response.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave,205*205,180);
d2=reshape(cond_1200_ave,205*205,180);

GA_100_del1100_s1=cat(2,GA_100_del1100_s1,nanmean(d(roi_s1,:),1)');
GA_100_del1100_s2=cat(2,GA_100_del1100_s2,nanmean(d(roi_s2,:),1)');
GA_100_del1100_m1=cat(2,GA_100_del1100_m1,nanmean(d(roi_m1,:),1)');
GA_100_del1100_a1=cat(2,GA_100_del1100_a1,nanmean(d(roi_a1,:),1)');
GA_100_del1100_alm=cat(2,GA_100_del1100_alm,nanmean(d(roi_alm,:),1)');
GA_100_del1100_m2=cat(2,GA_100_del1100_m2,nanmean(d(roi_m2,:),1)');

GA_1200_del1100_s1=cat(2,GA_1200_del1100_s1,nanmean(d2(roi_s1,:),1)');
GA_1200_del1100_s2=cat(2,GA_1200_del1100_s2,nanmean(d2(roi_s2,:),1)');
GA_1200_del1100_m1=cat(2,GA_1200_del1100_m1,nanmean(d2(roi_m1,:),1)');
GA_1200_del1100_a1=cat(2,GA_1200_del1100_a1,nanmean(d2(roi_a1,:),1)');
GA_1200_del1100_alm=cat(2,GA_1200_del1100_alm,nanmean(d2(roi_alm,:),1)');
GA_1200_del1100_m2=cat(2,GA_1200_del1100_m2,nanmean(d2(roi_m2,:),1)');

cd D:\intrinsic\20150129\a\Matt_files
load('cond_100_ave_clean_norm_response.mat')
load('cond_1200_ave_clean_norm_response.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave,205*205,180);
d2=reshape(cond_1200_ave,205*205,180);

GA_100_del1100_s1=cat(2,GA_100_del1100_s1,nanmean(d(roi_s1,:),1)');
GA_100_del1100_s2=cat(2,GA_100_del1100_s2,nanmean(d(roi_s2,:),1)');
GA_100_del1100_m1=cat(2,GA_100_del1100_m1,nanmean(d(roi_m1,:),1)');
GA_100_del1100_a1=cat(2,GA_100_del1100_a1,nanmean(d(roi_a1,:),1)');
GA_100_del1100_alm=cat(2,GA_100_del1100_alm,nanmean(d(roi_alm,:),1)');
GA_100_del1100_m2=cat(2,GA_100_del1100_m2,nanmean(d(roi_m2,:),1)');

GA_1200_del1100_s1=cat(2,GA_1200_del1100_s1,nanmean(d2(roi_s1,:),1)');
GA_1200_del1100_s2=cat(2,GA_1200_del1100_s2,nanmean(d2(roi_s2,:),1)');
GA_1200_del1100_m1=cat(2,GA_1200_del1100_m1,nanmean(d2(roi_m1,:),1)');
GA_1200_del1100_a1=cat(2,GA_1200_del1100_a1,nanmean(d2(roi_a1,:),1)');
GA_1200_del1100_alm=cat(2,GA_1200_del1100_alm,nanmean(d2(roi_alm,:),1)');
GA_1200_del1100_m2=cat(2,GA_1200_del1100_m2,nanmean(d2(roi_m2,:),1)');

cd D:\intrinsic\20150129\b\Matt_files
load('cond_100_ave_clean_norm_response.mat')
load('cond_1200_ave_clean_norm_response.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave,205*205,180);
d2=reshape(cond_1200_ave,205*205,180);

GA_100_del1100_s1=cat(2,GA_100_del1100_s1,nanmean(d(roi_s1,:),1)');
GA_100_del1100_s2=cat(2,GA_100_del1100_s2,nanmean(d(roi_s2,:),1)');
GA_100_del1100_m1=cat(2,GA_100_del1100_m1,nanmean(d(roi_m1,:),1)');
GA_100_del1100_a1=cat(2,GA_100_del1100_a1,nanmean(d(roi_a1,:),1)');
GA_100_del1100_alm=cat(2,GA_100_del1100_alm,nanmean(d(roi_alm,:),1)');
GA_100_del1100_m2=cat(2,GA_100_del1100_m2,nanmean(d(roi_m2,:),1)');

GA_1200_del1100_s1=cat(2,GA_1200_del1100_s1,nanmean(d2(roi_s1,:),1)');
GA_1200_del1100_s2=cat(2,GA_1200_del1100_s2,nanmean(d2(roi_s2,:),1)');
GA_1200_del1100_m1=cat(2,GA_1200_del1100_m1,nanmean(d2(roi_m1,:),1)');
GA_1200_del1100_a1=cat(2,GA_1200_del1100_a1,nanmean(d2(roi_a1,:),1)');
GA_1200_del1100_alm=cat(2,GA_1200_del1100_alm,nanmean(d2(roi_alm,:),1)');
GA_1200_del1100_m2=cat(2,GA_1200_del1100_m2,nanmean(d2(roi_m2,:),1)');

% cd D:\intrinsic\20150129\e\Matt_files
% load('cond_100_ave_clean_norm_response.mat')
% load('cond_1200_ave_clean_norm_response.mat')
% load('rois_initial_205x205.mat')
% d=reshape(cond_100_ave,205*205,180);
% d2=reshape(cond_1200_ave,205*205,180);
% 
% GA_100_del1100_s1=cat(2,GA_100_del1100_s1,nanmean(d(roi_s1,:),1)');
% GA_100_del1100_s2=cat(2,GA_100_del1100_s2,nanmean(d(roi_s2,:),1)');
% GA_100_del1100_m1=cat(2,GA_100_del1100_m1,nanmean(d(roi_m1,:),1)');
% GA_100_del1100_a1=cat(2,GA_100_del1100_a1,nanmean(d(roi_a1,:),1)');
% GA_100_del1100_alm=cat(2,GA_100_del1100_alm,nanmean(d(roi_alm,:),1)');
% GA_100_del1100_m2=cat(2,GA_100_del1100_m2,nanmean(d(roi_m2,:),1)');
% 
% GA_1200_del1100_s1=cat(2,GA_1200_del1100_s1,nanmean(d2(roi_s1,:),1)');
% GA_1200_del1100_s2=cat(2,GA_1200_del1100_s2,nanmean(d2(roi_s2,:),1)');
% GA_1200_del1100_m1=cat(2,GA_1200_del1100_m1,nanmean(d2(roi_m1,:),1)');
% GA_1200_del1100_a1=cat(2,GA_1200_del1100_a1,nanmean(d2(roi_a1,:),1)');
% GA_1200_del1100_alm=cat(2,GA_1200_del1100_alm,nanmean(d2(roi_alm,:),1)');
% GA_1200_del1100_m2=cat(2,GA_1200_del1100_m2,nanmean(d2(roi_m2,:),1)');
% 
% cd D:\intrinsic\20150129\f\Matt_files
% load('cond_100_ave_clean_norm_response.mat')
% load('cond_1200_ave_clean_norm_response.mat')
% load('rois_initial_205x205.mat')
% d=reshape(cond_100_ave,205*205,180);
% d2=reshape(cond_1200_ave,205*205,180);
% 
% GA_100_del1100_s1=cat(2,GA_100_del1100_s1,nanmean(d(roi_s1,:),1)');
% GA_100_del1100_s2=cat(2,GA_100_del1100_s2,nanmean(d(roi_s2,:),1)');
% GA_100_del1100_m1=cat(2,GA_100_del1100_m1,nanmean(d(roi_m1,:),1)');
% GA_100_del1100_a1=cat(2,GA_100_del1100_a1,nanmean(d(roi_a1,:),1)');
% GA_100_del1100_alm=cat(2,GA_100_del1100_alm,nanmean(d(roi_alm,:),1)');
% GA_100_del1100_m2=cat(2,GA_100_del1100_m2,nanmean(d(roi_m2,:),1)');
% 
% GA_1200_del1100_s1=cat(2,GA_1200_del1100_s1,nanmean(d2(roi_s1,:),1)');
% GA_1200_del1100_s2=cat(2,GA_1200_del1100_s2,nanmean(d2(roi_s2,:),1)');
% GA_1200_del1100_m1=cat(2,GA_1200_del1100_m1,nanmean(d2(roi_m1,:),1)');
% GA_1200_del1100_a1=cat(2,GA_1200_del1100_a1,nanmean(d2(roi_a1,:),1)');
% GA_1200_del1100_alm=cat(2,GA_1200_del1100_alm,nanmean(d2(roi_alm,:),1)');
% GA_1200_del1100_m2=cat(2,GA_1200_del1100_m2,nanmean(d2(roi_m2,:),1)');

cd D:\intrinsic\20150129\g\Matt_files
load('cond_100_ave_clean_norm_response.mat')
load('cond_1200_ave_clean_norm_response.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave,205*205,180);
d2=reshape(cond_1200_ave,205*205,180);

GA_100_del1100_s1=cat(2,GA_100_del1100_s1,nanmean(d(roi_s1,:),1)');
GA_100_del1100_s2=cat(2,GA_100_del1100_s2,nanmean(d(roi_s2,:),1)');
GA_100_del1100_m1=cat(2,GA_100_del1100_m1,nanmean(d(roi_m1,:),1)');
GA_100_del1100_a1=cat(2,GA_100_del1100_a1,nanmean(d(roi_a1,:),1)');
GA_100_del1100_alm=cat(2,GA_100_del1100_alm,nanmean(d(roi_alm,:),1)');
GA_100_del1100_m2=cat(2,GA_100_del1100_m2,nanmean(d(roi_m2,:),1)');

GA_1200_del1100_s1=cat(2,GA_1200_del1100_s1,nanmean(d2(roi_s1,:),1)');
GA_1200_del1100_s2=cat(2,GA_1200_del1100_s2,nanmean(d2(roi_s2,:),1)');
GA_1200_del1100_m1=cat(2,GA_1200_del1100_m1,nanmean(d2(roi_m1,:),1)');
GA_1200_del1100_a1=cat(2,GA_1200_del1100_a1,nanmean(d2(roi_a1,:),1)');
GA_1200_del1100_alm=cat(2,GA_1200_del1100_alm,nanmean(d2(roi_alm,:),1)');
GA_1200_del1100_m2=cat(2,GA_1200_del1100_m2,nanmean(d2(roi_m2,:),1)');

cd D:\intrinsic\20150130\a\Matt_files
load('cond_100_ave_clean_norm_response.mat')
load('cond_1200_ave_clean_norm_response.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave,205*205,180);
d2=reshape(cond_1200_ave,205*205,180);

GA_100_del1100_s1=cat(2,GA_100_del1100_s1,nanmean(d(roi_s1,:),1)');
GA_100_del1100_s2=cat(2,GA_100_del1100_s2,nanmean(d(roi_s2,:),1)');
GA_100_del1100_m1=cat(2,GA_100_del1100_m1,nanmean(d(roi_m1,:),1)');
GA_100_del1100_a1=cat(2,GA_100_del1100_a1,nanmean(d(roi_a1,:),1)');
GA_100_del1100_alm=cat(2,GA_100_del1100_alm,nanmean(d(roi_alm,:),1)');
GA_100_del1100_m2=cat(2,GA_100_del1100_m2,nanmean(d(roi_m2,:),1)');

GA_1200_del1100_s1=cat(2,GA_1200_del1100_s1,nanmean(d2(roi_s1,:),1)');
GA_1200_del1100_s2=cat(2,GA_1200_del1100_s2,nanmean(d2(roi_s2,:),1)');
GA_1200_del1100_m1=cat(2,GA_1200_del1100_m1,nanmean(d2(roi_m1,:),1)');
GA_1200_del1100_a1=cat(2,GA_1200_del1100_a1,nanmean(d2(roi_a1,:),1)');
GA_1200_del1100_alm=cat(2,GA_1200_del1100_alm,nanmean(d2(roi_alm,:),1)');
GA_1200_del1100_m2=cat(2,GA_1200_del1100_m2,nanmean(d2(roi_m2,:),1)');



x=(1:180)*0.05-2.7;

figure;errorbar(x,nanmean(GA_100_del1100_s1,2),nanstd(GA_100_del1100_s1,0,2)/sqrt(size(GA_100_del1100_s1,2)),'b')
hold on
errorbar(x,nanmean(GA_100_del1100_s2,2),nanstd(GA_100_del1100_s2,0,2)/sqrt(size(GA_100_del1100_s2,2)),'c')
errorbar(x,nanmean(GA_100_del1100_m1,2),nanstd(GA_100_del1100_m1,0,2)/sqrt(size(GA_100_del1100_m1,2)),'r')
errorbar(x,nanmean(GA_100_del1100_m2,2),nanstd(GA_100_del1100_m2,0,2)/sqrt(size(GA_100_del1100_m2,2)),'k')
errorbar(x,nanmean(GA_100_del1100_a1,2),nanstd(GA_100_del1100_a1,0,2)/sqrt(size(GA_100_del1100_a1,2)),'g')
errorbar(x,nanmean(GA_100_del1100_alm,2),nanstd(GA_100_del1100_alm,0,2)/sqrt(size(GA_100_del1100_alm,2)),'m')


figure;errorbar(x,nanmean(GA_1200_del1100_s1,2),nanstd(GA_100_del1100_s1,0,2)/sqrt(size(GA_1200_del1100_s1,2)),'b')
hold on
errorbar(x,nanmean(GA_1200_del1100_s2,2),nanstd(GA_1200_del1100_s2,0,2)/sqrt(size(GA_1200_del1100_s2,2)),'c')
errorbar(x,nanmean(GA_1200_del1100_m1,2),nanstd(GA_1200_del1100_m1,0,2)/sqrt(size(GA_1200_del1100_m1,2)),'r')
errorbar(x,nanmean(GA_1200_del1100_m2,2),nanstd(GA_1200_del1100_m2,0,2)/sqrt(size(GA_1200_del1100_m2,2)),'k')
errorbar(x,nanmean(GA_1200_del1100_a1,2),nanstd(GA_1200_del1100_a1,0,2)/sqrt(size(GA_1200_del1100_a1,2)),'g')
errorbar(x,nanmean(GA_1200_del1100_alm,2),nanstd(GA_1200_del1100_alm,0,2)/sqrt(size(GA_1200_del1100_alm,2)),'m')



figure;errorbar(x,nanmean(GA_100_del1100_s1,2),nanstd(GA_100_del1100_s1,0,2)/sqrt(size(GA_100_del1100_s1,2)),'b')
hold on
errorbar(x,nanmean(GA_1200_del1100_s1,2),nanstd(GA_1200_del1100_s1,0,2)/sqrt(size(GA_1200_del1100_s1,2)),'c')
title('S1')

figure;errorbar(x,nanmean(GA_100_del1100_s2,2),nanstd(GA_100_del1100_s2,0,2)/sqrt(size(GA_100_del1100_s2,2)),'--b')
hold on
errorbar(x,nanmean(GA_1200_del1100_s2,2),nanstd(GA_1200_del1100_s2,0,2)/sqrt(size(GA_1200_del1100_s2,2)),'--c')
title('S1')

figure;errorbar(x,nanmean(GA_100_del1100_m1,2),nanstd(GA_100_del1100_m1,0,2)/sqrt(size(GA_100_del1100_m1,2)),'r')
hold on
errorbar(x,nanmean(GA_1200_del1100_m1,2),nanstd(GA_1200_del1100_m1,0,2)/sqrt(size(GA_1200_del1100_m1,2)),'m')
title('M1')

figure;errorbar(x,nanmean(GA_100_del1100_m2,2),nanstd(GA_100_del1100_m2,0,2)/sqrt(size(GA_100_del1100_m2,2)),'r')
hold on
errorbar(x,nanmean(GA_1200_del1100_m2,2),nanstd(GA_1200_del1100_m2,0,2)/sqrt(size(GA_1200_del1100_m2,2)),'m')
title('M2')

figure;errorbar(x,nanmean(GA_100_del1100_a1,2),nanstd(GA_100_del1100_a1,0,2)/sqrt(size(GA_100_del1100_a1,2)),'g')
hold on
errorbar(x,nanmean(GA_1200_del1100_a1,2),nanstd(GA_1200_del1100_a1,0,2)/sqrt(size(GA_1200_del1100_a1,2)),'y')
title('A1')

figure;errorbar(x,nanmean(GA_100_del1100_alm,2),nanstd(GA_100_del1100_alm,0,2)/sqrt(size(GA_100_del1100_alm,2)),'--r')
hold on
errorbar(x,nanmean(GA_1200_del1100_alm,2),nanstd(GA_1200_del1100_alm,0,2)/sqrt(size(GA_1200_del1100_alm,2)),'--m')
title('Alm')

time=113:148;
diff_s1=GA_100_del1100_s1-GA_1200_del1100_s1;
diff_s2=GA_100_del1100_s2-GA_1200_del1100_s2;
diff_m1=GA_100_del1100_m1-GA_1200_del1100_m1;
diff_m2=GA_100_del1100_m2-GA_1200_del1100_m2;
diff_a1=GA_100_del1100_a1-GA_1200_del1100_a1;
diff_alm=GA_100_del1100_alm-GA_1200_del1100_alm;
figure;errorbar(x(time),nanmean(diff_s1(time,:),2),nanstd(diff_s1(time,:),0,2)/sqrt(size(diff_s1,2)),'b')
hold on
errorbar(x(time),nanmean(diff_s2(time,:),2),nanstd(diff_s2(time,:),0,2)/sqrt(size(diff_s2,2)),'c')
errorbar(x(time),nanmean(diff_m1(time,:),2),nanstd(diff_m1(time,:),0,2)/sqrt(size(diff_m1,2)),'r')
errorbar(x(time),nanmean(diff_m2(time,:),2),nanstd(diff_m2(time,:),0,2)/sqrt(size(diff_m2,2)),'k')
errorbar(x(time),nanmean(diff_alm(time,:),2),nanstd(diff_alm(time,:),0,2)/sqrt(size(diff_alm,2)),'m')
errorbar(x(time),nanmean(diff_a1(time,:),2),nanstd(diff_a1(time,:),0,2)/sqrt(size(diff_a1,2)),'g')
legend('s1','s2','m1','m2','alm','a1')
plot(x(time),zeros(1,size(time,2)),'k')

time=128:138;
figure;bar([nanmean(nanmean(diff_s1(time,:),1)) nanmean(nanmean(diff_s2(time,:),1)) nanmean(nanmean(diff_a1(time,:),1)) nanmean(nanmean(diff_m1(time,:),1)) nanmean(nanmean(diff_m2(time,:),1)) nanmean(nanmean(diff_alm(time,:),1))])
hold on
errorbar([nanmean(nanmean(diff_s1(time,:),1)) nanmean(nanmean(diff_s2(time,:),1)) nanmean(nanmean(diff_a1(time,:),1)) nanmean(nanmean(diff_m1(time,:),1)) nanmean(nanmean(diff_m2(time,:),1)) nanmean(nanmean(diff_alm(time,:),1))],[nanstd(nanmean(diff_s1(time,:),1)) nanstd(nanmean(diff_s2(time,:),1)) nanstd(nanmean(diff_a1(time,:),1)) nanstd(nanmean(diff_m1(time,:),1)) nanstd(nanmean(diff_m2(time,:),1)) nanstd(nanmean(diff_alm(time,:),1))]/sqrt(size(diff_s1,2)))
signrank(nanmean(diff_s1(time,:),1))
signrank(nanmean(diff_s2(time,:),1))
signrank(nanmean(diff_a1(time,:),1))
signrank(nanmean(diff_m1(time,:),1))
signrank(nanmean(diff_m2(time,:),1))
signrank(nanmean(diff_alm(time,:),1))






%%


for i=1:180
    [p h_s1(i)]=signrank(nanmean(diff_s1(i,:),1));
    [p h_s2(i)]=signrank(nanmean(diff_s2(i,:),1));
end
hh_s1=nan*ones(1,180);
hh_s1(h_s1)=1;
hh_s2=nan*ones(1,180);
hh_s2(h_s2)=1;

figure;errorbar(x,nanmean(diff_s1,2),nanstd(diff_s1,0,2)/sqrt(size(diff_s1,2)),'b')
hold on
errorbar(x,nanmean(diff_s2,2),nanstd(diff_s2,0,2)/sqrt(size(diff_s2,2)),'c')
plot(x,hh_s1*0.019,'Color','b','Marker','*','Linestyle','none')
plot(x,hh_s2*0.02,'Color','c','Marker','*','Linestyle','none')
plot(x,zeros(1,180),'k')
   



for i=1:180
    [p h_m1(i)]=signrank(nanmean(diff_m1(i,:),1));
    [p h_m2(i)]=signrank(nanmean(diff_m2(i,:),1));
    [p h_alm(i)]=signrank(nanmean(diff_alm(i,:),1));
end
hh_m1=nan*ones(1,180);
hh_m1(h_m1)=1;
hh_m2=nan*ones(1,180);
hh_m2(h_m2)=1;
hh_alm=nan*ones(1,180);
hh_alm(h_alm)=1;
figure;errorbar(x,nanmean(diff_m1,2),nanstd(diff_m1,0,2)/sqrt(size(diff_m1,2)),'r')
hold on
errorbar(x,nanmean(diff_m2,2),nanstd(diff_m2,0,2)/sqrt(size(diff_m2,2)),'k')
errorbar(x,nanmean(diff_alm,2),nanstd(diff_alm,0,2)/sqrt(size(diff_alm,2)),'m')
plot(x,hh_m1*0.022,'Color','r','Marker','*','Linestyle','none')
plot(x,hh_m2*0.023,'Color','k','Marker','*','Linestyle','none')
plot(x,hh_alm*0.024,'Color','m','Marker','*','Linestyle','none')
plot(x,zeros(1,180),'k')
   



for i=1:180
    [p h_a1(i)]=signrank(nanmean(diff_a1(i,:),1));
end
hh=nan*ones(1,180);
hh(h_a1)=1;
figure;errorbar(x,nanmean(diff_a1,2),nanstd(diff_a1,0,2)/sqrt(size(diff_a1,2)),'g')
hold on
plot(x,hh*0.02,'Color','g','Marker','*','Linestyle','none')
plot(x,zeros(1,180),'k')
   


%%
cd D:\intrinsic\20150128\c\Matt_files
load('cond_100_ave.mat')
load('cond_1200_ave.mat')
load('rois_initial_205x205.mat')
d=reshape(cond_100_ave,205*205,180);
d2=reshape(cond_1200_ave,205*205,180);

GA_100_del2000_s1=nanmean(d(roi_s1,:),1)';
GA_100_del2000_s2=nanmean(d(roi_s2,:),1)';
GA_100_del2000_m1=nanmean(d(roi_m1,:),1)';
GA_100_del2000_a1=nanmean(d(roi_a1,:),1)';
GA_100_del2000_alm=nanmean(d(roi_alm,:),1)';
GA_100_del2000_m2=nanmean(d(roi_m2,:),1)';

GA_1200_del2000_s1=nanmean(d2(roi_s1,:),1)';
GA_1200_del2000_s2=nanmean(d2(roi_s2,:),1)';
GA_1200_del2000_m1=nanmean(d2(roi_m1,:),1)';
GA_1200_del2000_a1=nanmean(d2(roi_a1,:),1)';
GA_1200_del2000_alm=nanmean(d2(roi_alm,:),1)';
GA_1200_del2000_m2=nanmean(d2(roi_m2,:),1)';

x=(1:180)*0.05-2.7;
diff_s1=GA_100_del2000_s1-GA_1200_del2000_s1;
diff_s2=GA_100_del2000_s2-GA_1200_del2000_s2;
diff_m1=GA_100_del2000_m1-GA_1200_del2000_m1;
diff_m2=GA_100_del2000_m2-GA_1200_del2000_m2;
diff_a1=GA_100_del2000_a1-GA_1200_del2000_a1;
diff_alm=GA_100_del2000_alm-GA_1200_del2000_alm;
figure;plot(x,nanmean(diff_s1,2),'b')
hold on
plot(x,nanmean(diff_s2,2),'c')
plot(x,nanmean(diff_m1,2),'r')
plot(x,nanmean(diff_m2,2),'k')
plot(x,nanmean(diff_alm,2),'m')
plot(x,nanmean(diff_a1,2),'g')
legend('s1','s2','m1','m2','alm','a1')
plot(x,zeros(1,180),'k')


%%
figure;errorbar(x,nanmean(GA_100_del1100_m2,2)-1,nanstd(GA_100_del1100_m2,0,2)/sqrt(size(GA_100_del1100_m2,2)),'r')
hold on
errorbar(x,nanmean(GA_1200_del1100_m2,2)-1,nanstd(GA_1200_del1100_m2,0,2)/sqrt(size(GA_1200_del1100_m2,2)),'--k')
plot(x,hh_m2*0.05,'Color','r','Marker','*','Linestyle','none')
plot(x,zeros(1,180),'k')


figure;errorbar(x,nanmean(GA_100_del1100_a1,2)-1,nanstd(GA_100_del1100_a1,0,2)/sqrt(size(GA_100_del1100_a1,2)),'g')
hold on
errorbar(x,nanmean(GA_1200_del1100_a1,2)-1,nanstd(GA_1200_del1100_a1,0,2)/sqrt(size(GA_1200_del1100_a1,2)),'--k')
plot(x,hh*0.02,'Color','g','Marker','*','Linestyle','none')
plot(x,zeros(1,180),'k')


figure;errorbar(x,nanmean(GA_100_del1100_alm,2)-1,nanstd(GA_100_del1100_alm,0,2)/sqrt(size(GA_100_del1100_alm,2)),'m')
hold on
errorbar(x,nanmean(GA_1200_del1100_alm,2)-1,nanstd(GA_1200_del1100_alm,0,2)/sqrt(size(GA_1200_del1100_alm,2)),'--k')
plot(x,hh_alm*0.02,'Color','m','Marker','*','Linestyle','none')
plot(x,zeros(1,180),'k')


figure;errorbar(x,nanmean(GA_100_del1100_s2,2)-1,nanstd(GA_100_del1100_s2,0,2)/sqrt(size(GA_100_del1100_s2,2)),'c')
hold on
errorbar(x,nanmean(GA_1200_del1100_s2,2)-1,nanstd(GA_1200_del1100_s2,0,2)/sqrt(size(GA_1200_del1100_s2,2)),'--k')
plot(x,hh_s2*0.02,'Color','c','Marker','*','Linestyle','none')
plot(x,zeros(1,180),'k')



figure;errorbar(x,nanmean(GA_100_del1100_s1,2)-1,nanstd(GA_100_del1100_s1,0,2)/sqrt(size(GA_100_del1100_s1,2)),'b')
hold on
errorbar(x,nanmean(GA_100_del1100_s2,2)-1,nanstd(GA_100_del1100_s2,0,2)/sqrt(size(GA_100_del1100_s2,2)),'c')
errorbar(x,nanmean(GA_100_del1100_m1,2)-1,nanstd(GA_100_del1100_m1,0,2)/sqrt(size(GA_100_del1100_m1,2)),'r')
errorbar(x,nanmean(GA_100_del1100_m2,2)-1,nanstd(GA_100_del1100_m2,0,2)/sqrt(size(GA_100_del1100_m2,2)),'k')
errorbar(x,nanmean(GA_100_del1100_alm,2)-1,nanstd(GA_100_del1100_alm,0,2)/sqrt(size(GA_100_del1100_alm,2)),'m')
errorbar(x,nanmean(GA_100_del1100_a1,2)-1,nanstd(GA_100_del1100_a1,0,2)/sqrt(size(GA_100_del1100_a1,2)),'g')
plot(x,zeros(1,180),'k')


figure;errorbar(x,nanmean(GA_1200_del1100_s1,2)-1,nanstd(GA_1200_del1100_s1,0,2)/sqrt(size(GA_1200_del1100_s1,2)),'b')
hold on
errorbar(x,nanmean(GA_1200_del1100_s2,2)-1,nanstd(GA_1200_del1100_s2,0,2)/sqrt(size(GA_1200_del1100_s2,2)),'c')
errorbar(x,nanmean(GA_1200_del1100_m1,2)-1,nanstd(GA_1200_del1100_m1,0,2)/sqrt(size(GA_1200_del1100_m1,2)),'r')
errorbar(x,nanmean(GA_1200_del1100_m2,2)-1,nanstd(GA_1200_del1100_m2,0,2)/sqrt(size(GA_1200_del1100_m2,2)),'k')
errorbar(x,nanmean(GA_1200_del1100_alm,2)-1,nanstd(GA_1200_del1100_alm,0,2)/sqrt(size(GA_1200_del1100_alm,2)),'m')
errorbar(x,nanmean(GA_1200_del1100_a1,2)-1,nanstd(GA_1200_del1100_a1,0,2)/sqrt(size(GA_1200_del1100_a1,2)),'g')
plot(x,zeros(1,180),'k')

