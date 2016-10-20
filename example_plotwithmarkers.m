close all
clear all
disp('==== test_export_fig.m ======');


figure('color','white','position',[100 100 800 800]);



subplot(2,2,1);
hold on;

x = (0:0.01:1);
nbMarkers = 11;

f1 = x;
pointeur(1) = plotwithmarkers(x,f1,nbMarkers,'-or','linewidth',1);
legendText{1} = '$y=x$';

f2 = x+0.1*x.^2;
pointeur(2) = plotwithmarkers(x,f2,nbMarkers,'--pb','linewidth',2);
legendText{2} = 'My Curve';

f3 = sqrt(x);
pointeur(3) = plotwithmarkers(x,f3,nbMarkers,'-vg','linewidth',1);
legendText{3} = '$y=\sqrt{x}$';

xlabel('Standard utilisation of plotwithmarkers');

legend(pointeur,legendText,...
    'location','northwest',...
    'interpreter','latex')





subplot(2,2,2);
hold on;

x = (1/1.5).^(0:30);
nbMarkers = 11;

f1 = log(x).*sqrt(x);
pointeur(1) = plotwithmarkers(x,f1,nbMarkers,'logscale','random',0.8,'-or','markersize',10);
legendText{1} = '$log(x)\sqrt{x}$';

f2 = log(x).*x;
pointeur(2) = plotwithmarkers(x,f2,nbMarkers,'logscale','random',0.8,'--pb','markersize',10);
legendText{2} = '$log(x)\times x$';

f3 = sqrt(x);
pointeur(3) = plotwithmarkers(x,f3,nbMarkers,'logscale','random',0.8,'-vg','markersize',10);
legendText{3} = '$\sqrt{x}$';

set(gca,'xscale','log');

xlabel('A little bit of randomness in the position of the markers\newline{}Options : logscale + random 0.8');

legend(pointeur,legendText,...
    'location','northwest',...
    'interpreter','latex')






subplot(2,2,3);
hold on;

x = (0:0.01:1);
nbMarkers = 11;

f1 = x;
pointeur(1) = plotwithmarkers(x,f1,nbMarkers,'-or','offset',0/3,'markersize',8);
legendText{1} = '$y=x$';

f2 = x+0.1*x.^2;
pointeur(2) = plotwithmarkers(x,f2,nbMarkers,'--pb','offset',1/3,'markersize',8);
legendText{2} = 'My Curve';

f3 = x+0.1*sqrt(x);
pointeur(3) = plotwithmarkers(x,f3,nbMarkers,'-vg','offset',2/3,'markersize',8);
legendText{3} = '$y=\sqrt{x}$';

xlabel('Small shifts of the markers with the option "offset"');

legend(pointeur,legendText,...
    'location','northwest',...
    'interpreter','latex')




subplot(2,2,4);
hold on;

x = (1/1.5).^(0:30);
nbMarkers = 11;

f1 = log(x).*sqrt(x);
pointeur(1) = plotwithmarkers(x,f1,nbMarkers,'logscale','nicemarkers','linestyle','-','linewidth',1,'marker','o','color','r','markersize',10);
legendText{1} = '$log(x)\sqrt{x}$';

f2 = log(x).*x;
pointeur(2) = plotwithmarkers(x,f2,nbMarkers,'logscale','nicemarkers','linestyle','-','linewidth',1,'marker','p','color','b','markersize',10);
legendText{2} = '$log(x)\times x$';

f3 = sqrt(x);
pointeur(3) = plotwithmarkers(x,f3,nbMarkers,'logscale','nicemarkers','linestyle','-','linewidth',1,'marker','v','color','g','markersize',10);
legendText{3} = '$\sqrt{x}$';

set(gca,'xscale','log');

xlabel('Options : logscale + nicemarkers');

pl = legend(pointeur,legendText,...
    'location','northwest',...
    'interpreter','latex')






