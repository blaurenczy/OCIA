%% power presentation

cond=[4 3 6 2];    %choose conditions
time=112;          %choose time frames (starting from the begining)
freq=32;

eval(['load power_cond',int2str(cond(1))])
disp(['cond ',int2str(cond(1))])
a=zeros(freq,time,10000);
eval(['a(:,:,pixels)=power_cond',int2str(cond(1)),'(:,1:time,:);'])
a=shiftdim(a,2);
a(isnan(a))=0;
eval(['clear power_cond',int2str(cond(1))])


eval(['load power_cond',int2str(cond(2))])
disp(['cond ',int2str(cond(2))])
b=zeros(freq,time,10000);
eval(['b(:,:,pixels)=power_cond',int2str(cond(2)),'(:,1:time,:);'])
b=shiftdim(b,2);
b(isnan(b))=0;
eval(['clear power_cond',int2str(cond(2))])


eval(['load power_cond',int2str(cond(3))])
disp(['cond ',int2str(cond(3))])
c=zeros(freq,time,10000);
eval(['c(:,:,pixels)=power_cond',int2str(cond(3)),'(:,1:time,:);'])
c=shiftdim(c,2);
c(isnan(c))=0;
eval(['clear power_cond',int2str(cond(3))])


eval(['load power_cond',int2str(cond(4))])
disp(['cond ',int2str(cond(4))])
d=zeros(freq,time,10000);
eval(['d(:,:,pixels)=power_cond',int2str(cond(4)),'(:,1:time,:);'])
d=shiftdim(d,2);
d(isnan(d))=0;
eval(['clear power_cond',int2str(cond(4))])


%% db scale

a=10*log10(a./repmat(mean(a(:,:,2:11),3),[1 1 112]));
a(isnan(a))=0;
a(isinf(a))=0;

b=10*log10(b./repmat(mean(b(:,:,2:11),3),[1 1 112]));
b(isnan(b))=0;
b(isinf(b))=0;

c=10*log10(c./repmat(mean(c(:,:,2:11),3),[1 1 112]));
c(isnan(c))=0;
c(isinf(c))=0;


%% plot conditions

figure;plotspconds(cat(3,squeeze(mean(a(:,4:9,:),2)),squeeze(mean(b(:,4:9,:),2)),squeeze(mean(c(:,4:9,:),2)),squeeze(mean(d(:,4:9,:),2))),100,100,10);title('alpha coherence');
figure;plotspconds(cat(3,squeeze(mean(a(:,10:15,:),2)),squeeze(mean(b(:,10:15,:),2)),squeeze(mean(c(:,10:15,:),2)),squeeze(mean(d(:,10:15,:),2))),100,100,10);title('beta coherence');
figure;plotspconds(cat(3,squeeze(mean(a(:,15:end,:),2)),squeeze(mean(b(:,15:end,:),2)),squeeze(mean(c(:,15:end,:),2)),squeeze(mean(d(:,15:end,:),2))),100,100,10);title('gamma coherence');
figure;plotspconds(cat(3,squeeze(mean(a(:,15:20,:),2)),squeeze(mean(b(:,15:20,:),2)),squeeze(mean(c(:,15:20,:),2)),squeeze(mean(d(:,15:20,:),2))),100,100,10);

figure;plotspconds(cat(3,squeeze(mean(a(:,:,20:30),3)),squeeze(mean(b(:,:,20:30),3)),squeeze(mean(c(:,:,20:30),3)),squeeze(mean(d(:,:,20:30),3))),100,100,10);title('frequency content onset');
figure;plotspconds(cat(3,squeeze(mean(a(:,:,45:65),3)),squeeze(mean(b(:,:,45:65),3)),squeeze(mean(c(:,:,45:65),3)),squeeze(mean(d(:,:,45:65),3))),100,100,10);title('frequency content offset');

clip=1.5e-8;
%figure;mimg(squeeze(mean(mean(a(:,4:9,20:30),3),2)),100,100,0,clip);colormap(mapgeog);title('alpha coherence cond a');
%figure;mimg(abs(squeeze(mean(mean(b(:,4:9,20:30),3),2))).^2,100,100,0,clip);colormap(mapgeog);title('alpha coherence cond b');
%figure;mimg(abs(squeeze(mean(mean(c(:,4:9,20:30),3),2))).^2,100,100,0,clip);colormap(mapgeog);title('alpha coherence cond c');
%figure;mimg(abs(squeeze(mean(mean(d(:,4:9,20:30),3),2))).^2,100,100,0,clip);colormap(mapgeog);title('alpha coherence cond d');
figure;mimg(mfilt2(squeeze(mean(mean(a(:,4:9,20:30),3),2)),100,100,1,'lm'),100,100,0,clip);colormap(mapgeog);
figure;mimg(mfilt2(squeeze(mean(mean(b(:,4:9,20:30),3),2)),100,100,1,'lm'),100,100,0,clip);colormap(mapgeog);
%figure;mimg(mfilt2(squeeze(mean(mean(abs(a(:,4:9,20:30)).^2,3),2)),100,100,1,'lm'),100,100,0,clip);colormap(mapgeog);
%figure;mimg(mfilt2(squeeze(mean(mean(abs(b(:,4:9,20:30)).^2,3),2)),100,100,1,'lm'),100,100,0,clip);colormap(mapgeog);
figure;mimg(mfilt2(squeeze(mean(mean(c(:,4:9,20:30),3),2)),100,100,1,'lm'),100,100,0,clip);colormap(mapgeog);
figure;mimg(mfilt2(squeeze(mean(mean(d(:,4:9,20:30),3),2)),100,100,1,'lm'),100,100,0,clip);colormap(mapgeog);
clip=0.0025;
figure;mimg(mfilt2(abs(squeeze(mean(mean(a(:,10:15,20:30),3),2))).^2,100,100,1,'lm'),100,100,0,clip);colormap(mapgeog);
figure;mimg(mfilt2(abs(squeeze(mean(mean(b(:,10:15,20:30),3),2))).^2,100,100,1,'lm'),100,100,0,clip);colormap(mapgeog);
figure;mimg(mfilt2(abs(squeeze(mean(mean(c(:,10:15,20:30),3),2))).^2,100,100,1,'lm'),100,100,0,clip);colormap(mapgeog);
figure;mimg(mfilt2(abs(squeeze(mean(mean(d(:,10:15,20:30),3),2))).^2,100,100,1,'lm'),100,100,0,clip);colormap(mapgeog);
clip=0.001;
figure;mimg(mfilt2(abs(squeeze(mean(mean(a(:,15:20,20:30),3),2))).^2,100,100,1,'lm'),100,100,0,clip);colormap(mapgeog);
figure;mimg(mfilt2(abs(squeeze(mean(mean(b(:,15:20,20:30),3),2))).^2,100,100,1,'lm'),100,100,0,clip);colormap(mapgeog);
figure;mimg(mfilt2(abs(squeeze(mean(mean(c(:,15:20,20:30),3),2))).^2,100,100,1,'lm'),100,100,0,clip);colormap(mapgeog);
figure;mimg(mfilt2(abs(squeeze(mean(mean(d(:,15:20,20:30),3),2))).^2,100,100,1,'lm'),100,100,0,clip);colormap(mapgeog);
clip=0.0005;
figure;mimg(mfilt2(abs(squeeze(mean(mean(a(:,15:end,20:30),3),2))).^2,100,100,1,'lm'),100,100,0,clip);colormap(mapgeog);
figure;mimg(mfilt2(abs(squeeze(mean(mean(b(:,15:end,20:30),3),2))).^2,100,100,1,'lm'),100,100,0,clip);colormap(mapgeog);
figure;mimg(mfilt2(abs(squeeze(mean(mean(c(:,15:end,20:30),3),2))).^2,100,100,1,'lm'),100,100,0,clip);colormap(mapgeog);
figure;mimg(mfilt2(abs(squeeze(mean(mean(d(:,15:end,20:30),3),2))).^2,100,100,1,'lm'),100,100,0,clip);colormap(mapgeog);

%figure;plotspconds(cat(3,unwrap(angle(squeeze(mean(a(:,4:9,:),2))),[],2),unwrap(angle(squeeze(mean(b(:,4:9,:),2))),[],2),unwrap(angle(squeeze(mean(c(:,4:9,:),2))),[],2),unwrap(angle(squeeze(mean(d(:,4:9,:),2))),[],2)),100,100,10);title('alpha phase');
%figure;plotspconds(cat(3,angle(squeeze(mean(a(:,1:4,:),2))),angle(squeeze(mean(b(:,1:4,:),2))),angle(squeeze(mean(c(:,1:4,:),2))),angle(squeeze(mean(d(:,1:4,:),2)))),100,100,10);
figure;plotspconds(cat(3,angle(squeeze(mean(a(:,4:9,:),2))),angle(squeeze(mean(b(:,4:9,:),2))),angle(squeeze(mean(c(:,4:9,:),2))),angle(squeeze(mean(d(:,4:9,:),2)))),100,100,10);
figure;plotspconds(cat(3,angle(squeeze(mean(a(:,10:15,:),2))),angle(squeeze(mean(b(:,10:15,:),2))),angle(squeeze(mean(c(:,10:15,:),2))),angle(squeeze(mean(d(:,10:15,:),2)))),100,100,10);title('beta phase');
figure;plotspconds(cat(3,angle(squeeze(mean(a(:,15:end,:),2))),angle(squeeze(mean(b(:,15:end,:),2))),angle(squeeze(mean(c(:,15:end,:),2))),angle(squeeze(mean(d(:,15:end,:),2)))),100,100,10);title('gamma phase');


figure;plotspconds(abs(squeeze(mean(a(:,:,20:30),3))).^2-abs(squeeze(mean(b(:,:,20:30),3))).^2,100,100,10);title('differential frequency content onset');
figure;plotspconds(abs(squeeze(mean(a(:,:,45:65),3))).^2-abs(squeeze(mean(b(:,:,45:65),3))).^2,100,100,10);title('differential frequency content offset');


figure;plotspconds(abs(squeeze(mean(a(:,2:5,:),2))).^2-abs(squeeze(mean(b(:,2:5,:),2))).^2,100,100,10);title('differential frequency content onset');
figure;plotspconds(abs(squeeze(mean(a(:,4:9,:),2))).^2-abs(squeeze(mean(b(:,4:9,:),2))).^2,100,100,10);title('differential frequency content onset');
figure;plotspconds(abs(squeeze(mean(a(:,10:15,:),2))).^2-abs(squeeze(mean(b(:,10:15,:),2))).^2,100,100,10);title('differential frequency content onset');
figure;plotspconds(abs(squeeze(mean(a(:,15:end,:),2))).^2-abs(squeeze(mean(b(:,15:end,:),2))).^2,100,100,10);title('differential frequency content onset');
%plot areas


figure;plot(cat(2,squeeze(mean(mean(a(roi_V1,4:9,:),2),1)),squeeze(mean(mean(b(roi_V1,4:9,:),2),1)),squeeze(mean(mean(c(roi_V1,4:9,:),2),1)),squeeze(mean(mean(d(roi_V1,4:9,:),2),1))))
figure;plot(cat(2,squeeze(mean(mean(a(roi_V1_2,4:9,:),2),1)),squeeze(mean(mean(b(roi_V1_2,4:9,:),2),1)),squeeze(mean(mean(c(roi_V1_2,4:9,:),2),1)),squeeze(mean(mean(d(roi_V1_2,4:9,:),2),1))))
figure;plot(cat(2,squeeze(mean(mean(a(roi_V2,4:9,:),2),1)),squeeze(mean(mean(b(roi_V2,4:9,:),2),1)),squeeze(mean(mean(c(roi_V2,4:9,:),2),1)),squeeze(mean(mean(d(roi_V2,4:9,:),2),1))))
figure;plot(cat(2,squeeze(mean(mean(a(roi_V4,4:9,:),2),1)),squeeze(mean(mean(b(roi_V4,4:9,:),2),1)),squeeze(mean(mean(c(roi_V4,4:9,:),2),1)),squeeze(mean(mean(d(roi_V4,4:9,:),2),1))))


figure;plot(cat(2,squeeze(mean(mean(a(roi_V1,10:15,:),2),1)),squeeze(mean(mean(b(roi_V1,10:15,:),2),1)),squeeze(mean(mean(c(roi_V1,10:15,:),2),1)),squeeze(mean(mean(d(roi_V1,10:15,:),2),1))))
figure;plot(cat(2,squeeze(mean(mean(a(roi_V1_2,10:15,:),2),1)),squeeze(mean(mean(b(roi_V1_2,10:15,:),2),1)),squeeze(mean(mean(c(roi_V1_2,10:15,:),2),1)),squeeze(mean(mean(d(roi_V1_2,10:15,:),2),1))))
figure;plot(cat(2,squeeze(mean(mean(a(roi_V2,10:15,:),2),1)),squeeze(mean(mean(b(roi_V2,10:15,:),2),1)),squeeze(mean(mean(c(roi_V2,10:15,:),2),1)),squeeze(mean(mean(d(roi_V2,10:15,:),2),1))))
figure;plot(cat(2,squeeze(mean(mean(a(roi_V4,10:15,:),2),1)),squeeze(mean(mean(b(roi_V4,10:15,:),2),1)),squeeze(mean(mean(c(roi_V4,10:15,:),2),1)),squeeze(mean(mean(d(roi_V4,10:15,:),2),1))))


figure;plot((1:50/32:50),cat(2,squeeze(mean(mean(a(roi_V1,:,20:30),3),1)).',squeeze(mean(mean(b(roi_V1,:,20:30),3),1)).',squeeze(mean(mean(c(roi_V1,:,20:30),3),1)).',squeeze(mean(mean(d(roi_V1,:,20:30),3),1)).'))
figure;plot(cat(2,squeeze(mean(mean(a(roi_V1_2,:,20:30),3),1)).',squeeze(mean(mean(b(roi_V1_2,:,20:30),3),1)).',squeeze(mean(mean(c(roi_V1_2,:,20:30),3),1)).',squeeze(mean(mean(d(roi_V1_2,:,20:30),3),1)).'))
figure;plot(cat(2,squeeze(mean(mean(a(roi_V2,:,20:30),3),1)).',squeeze(mean(mean(b(roi_V2,:,20:30),3),1)).',squeeze(mean(mean(c(roi_V2,:,20:30),3),1)).',squeeze(mean(mean(d(roi_V2,:,20:30),3),1)).'))
figure;plot(cat(2,squeeze(mean(mean(a(roi_V4,:,20:30),3),1)).',squeeze(mean(mean(b(roi_V4,:,20:30),3),1)).',squeeze(mean(mean(c(roi_V4,:,20:30),3),1)).',squeeze(mean(mean(d(roi_V4,:,20:30),3),1)).'))

imagesc((10:10:1120),(1:50/32:50),squeeze(mean(a(roi_V1,:,:),1)),[0 1e-8]);colormap(mapgeog)



%a(roi_V4,:,:)=10;
%figure;mimg(abs(squeeze(mean(mean(a(:,4:9,25:28),2),3))).^2,100,100,0,1);colormap(mapgeog);

figure;
subplot(3,3,1);plot(cat(2,squeeze(mean(mean(a(roi_tar,4:9,:),2),1)),squeeze(mean(mean(b(roi_tar,4:9,:),2),1)),squeeze(mean(mean(c(roi_tar,4:9,:),2),1))));title('ROI target');xlim([0 112]);
subplot(3,3,2);plot(cat(2,squeeze(mean(mean(a(roi_f1,4:9,:),2),1)),squeeze(mean(mean(b(roi_f1,4:9,:),2),1)),squeeze(mean(mean(c(roi_f1,4:9,:),2),1))));title('ROI f1');xlim([0 112]);
subplot(3,3,3);plot(cat(2,squeeze(mean(mean(a(roi_f2,4:9,:),2),1)),squeeze(mean(mean(b(roi_f2,4:9,:),2),1)),squeeze(mean(mean(c(roi_f2,4:9,:),2),1))));title('ROI f2');xlim([0 112]);
subplot(3,3,4);plot(cat(2,squeeze(mean(mean(a(roi_f3,4:9,:),2),1)),squeeze(mean(mean(b(roi_f3,4:9,:),2),1)),squeeze(mean(mean(c(roi_f3,4:9,:),2),1))));title('ROI f3');xlim([0 112]);
%subplot(3,3,5);plot(cat(2,squeeze(mean(mean(a(roi_f4,4:9,:),2),1)),squeeze(mean(mean(b(roi_f4,4:9,:),2),1)),squeeze(mean(mean(c(roi_f4,4:9,:),2),1))));title('ROI f4');xlim([0 112]);
subplot(3,3,6);plot(cat(2,squeeze(mean(mean(a(roi_f5,4:9,:),2),1)),squeeze(mean(mean(b(roi_f5,4:9,:),2),1)),squeeze(mean(mean(c(roi_f5,4:9,:),2),1))));title('ROI f5');xlim([0 112]);
%subplot(3,3,7);plot(cat(2,squeeze(mean(mean(a(roi_V2tar_std,4:9,:),2),1)),squeeze(mean(mean(b(roi_V2tar_std,4:9,:),2),1)),squeeze(mean(mean(c(roi_V2tar_std,4:9,:),2),1))));title('ROI V2');xlim([0 112]);
subplot(3,3,8);plot(cat(2,squeeze(mean(mean(a(roi_V2tar,4:9,:),2),1)),squeeze(mean(mean(b(roi_V2tar,4:9,:),2),1)),squeeze(mean(mean(c(roi_V2tar,4:9,:),2),1))));title('ROI V2');xlim([0 112]);
%subplot(3,3,9);plot(cat(2,squeeze(mean(mean(a(roi_V4,4:9,:),2),1)),squeeze(mean(mean(b(roi_V4,4:9,:),2),1)),squeeze(mean(mean(c(roi_V4,4:9,:),2),1))));title('ROI V4');xlim([0 112]);



figure;
subplot(3,3,1);plot(cat(2,squeeze(mean(mean(a(roi_tar,10:15,:),2),1)),squeeze(mean(mean(b(roi_tar,10:15,:),2),1)),squeeze(mean(mean(c(roi_tar,10:15,:),2),1))));title('ROI target');xlim([0 112]);
subplot(3,3,2);plot(cat(2,squeeze(mean(mean(a(roi_f1,10:15,:),2),1)),squeeze(mean(mean(b(roi_f1,10:15,:),2),1)),squeeze(mean(mean(c(roi_f1,10:15,:),2),1))));title('ROI f1');xlim([0 112]);
subplot(3,3,3);plot(cat(2,squeeze(mean(mean(a(roi_f2,10:15,:),2),1)),squeeze(mean(mean(b(roi_f2,10:15,:),2),1)),squeeze(mean(mean(c(roi_f2,10:15,:),2),1))));title('ROI f2');xlim([0 112]);
subplot(3,3,4);plot(cat(2,squeeze(mean(mean(a(roi_f3,10:15,:),2),1)),squeeze(mean(mean(b(roi_f3,10:15,:),2),1)),squeeze(mean(mean(c(roi_f3,10:15,:),2),1))));title('ROI f3');xlim([0 112]);
%subplot(3,3,5);plot(cat(2,squeeze(mean(mean(a(roi_f4,10:15,:),2),1)),squeeze(mean(mean(b(roi_f4,10:15,:),2),1)),squeeze(mean(mean(c(roi_f4,10:15,:),2),1))));title('ROI f4');xlim([0 112]);
subplot(3,3,6);plot(cat(2,squeeze(mean(mean(a(roi_f5,10:15,:),2),1)),squeeze(mean(mean(b(roi_f5,10:15,:),2),1)),squeeze(mean(mean(c(roi_f5,10:15,:),2),1))));title('ROI f5');xlim([0 112]);
%subplot(3,3,7);plot(cat(2,squeeze(mean(mean(a(roi_V2tar_std,10:15,:),2),1)),squeeze(mean(mean(b(roi_V2tar_std,10:15,:),2),1)),squeeze(mean(mean(c(roi_V2tar_std,10:15,:),2),1))));title('ROI V2');xlim([0 112]);
subplot(3,3,8);plot(cat(2,squeeze(mean(mean(a(roi_V2tar,10:15,:),2),1)),squeeze(mean(mean(b(roi_V2tar,10:15,:),2),1)),squeeze(mean(mean(c(roi_V2tar,10:15,:),2),1))));title('ROI V2');xlim([0 112]);
%subplot(3,3,9);plot(cat(2,squeeze(mean(mean(a(roi_V4,10:15,:),2),1)),squeeze(mean(mean(b(roi_V4,10:15,:),2),1)),squeeze(mean(mean(c(roi_V4,10:15,:),2),1))));title('ROI V4');xlim([0 112]);



figure;
subplot(3,3,1);plot(cat(2,squeeze(mean(mean(a(roi_tar,8:15,:),2),1)),squeeze(mean(mean(b(roi_tar,8:15,:),2),1)),squeeze(mean(mean(c(roi_tar,8:15,:),2),1))));title('ROI target');xlim([0 112]);
subplot(3,3,2);plot(cat(2,squeeze(mean(mean(a(roi_f1,8:15,:),2),1)),squeeze(mean(mean(b(roi_f1,8:15,:),2),1)),squeeze(mean(mean(c(roi_f1,8:15,:),2),1))));title('ROI f1');xlim([0 112]);
subplot(3,3,3);plot(cat(2,squeeze(mean(mean(a(roi_f2,8:15,:),2),1)),squeeze(mean(mean(b(roi_f2,8:15,:),2),1)),squeeze(mean(mean(c(roi_f2,8:15,:),2),1))));title('ROI f2');xlim([0 112]);
subplot(3,3,4);plot(cat(2,squeeze(mean(mean(a(roi_f3,8:15,:),2),1)),squeeze(mean(mean(b(roi_f3,8:15,:),2),1)),squeeze(mean(mean(c(roi_f3,8:15,:),2),1))));title('ROI f3');xlim([0 112]);
%subplot(3,3,5);plot(cat(2,squeeze(mean(mean(a(roi_f4,8:15,:),2),1)),squeeze(mean(mean(b(roi_f4,8:15,:),2),1)),squeeze(mean(mean(c(roi_f4,8:15,:),2),1))));title('ROI f4');xlim([0 112]);
subplot(3,3,6);plot(cat(2,squeeze(mean(mean(a(roi_f5,8:15,:),2),1)),squeeze(mean(mean(b(roi_f5,8:15,:),2),1)),squeeze(mean(mean(c(roi_f5,8:15,:),2),1))));title('ROI f5');xlim([0 112]);
%subplot(3,3,7);plot(cat(2,squeeze(mean(mean(a(roi_V2tar_std,8:15,:),2),1)),squeeze(mean(mean(b(roi_V2tar_std,8:15,:),2),1)),squeeze(mean(mean(c(roi_V2tar_std,8:15,:),2),1))));title('ROI V2');xlim([0 112]);
subplot(3,3,8);plot(cat(2,squeeze(mean(mean(a(roi_V2tar,8:15,:),2),1)),squeeze(mean(mean(b(roi_V2tar,8:15,:),2),1)),squeeze(mean(mean(c(roi_V2tar,8:15,:),2),1))));title('ROI V2');xlim([0 112]);
%subplot(3,3,9);plot(cat(2,squeeze(mean(mean(a(roi_V4,8:15,:),2),1)),squeeze(mean(mean(b(roi_V4,8:15,:),2),1)),squeeze(mean(mean(c(roi_V4,8:15,:),2),1))));title('ROI V4');xlim([0 112]);







