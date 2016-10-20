function pointeur = plotwithmarkers(x,y,nbMarkers,varargin)

% Plot the curve x,y with regularly spaced markers.
% hl = plotwithmarker(x,f1,nbMarkers, ... style options ... )
%
% Examples:
%
% Standard use:
%   hl = plotwithmarker(x,f1,nbMarkers,'-or')
%
% Random space between markers:
%   hl = plotwithmarker(x,f1,nbMarkers,'-or','random',0.8)
%   The argument 'random' must be followed by a number in [0;1].
%   0 => no randomness at all
%   1 => total randomness of the markers position
%
% Regular spacing of the marker in log scale:
%   hl = plotwithmarker(x,f1,nbMarkers,'-or','logscale')
%   set(gca,'xscale','log');
%
% Nice markers:
%   hl = plotwithmarker(x,f1,nbMarkers,'-or','nicemarkers','markersize',10);
%   will give you a nice coloration of the markers.
%
% Regular spacing but with a small shift in the markers position:
%   hl(1) = plotwithmarker(x,f1,nbMarkers,'-or','offset',0/3);
%   hl(2) = plotwithmarker(x,f2,nbMarkers,'-or','offset',1/3);
%   hl(3) = plotwithmarker(x,f3,nbMarkers,'-or','offset',2/3);
%   will plot 3 curves with a shift of the markers.
%   Can not be used with the option "random"
%
% To have a marker at the begining and at the end of the curve
%   hl = plotwithmarker(x,f1,nbMarkers,'-or','forcefirst','forcelast');
%   Can be necessary if "offset" is used.


boolHold=ishold;
hold on

boolLog = false;
offsetValue = 0;
boolRandom = false;
randomValue = 0;
boolForceFirst = false;
boolForceLast = false;
boolNiceMarkers = false;
boolAdd = true;

x = x(:);
y = y(:);

if ~isequal(size(x),size(y))
    error('x & y are not the same size');
end

for i=length(varargin):-1:1
    if isequal(varargin{i},'logscale')
        boolLog = true;
        varargin(i) = [];
    elseif isequal(varargin{i},'linscale')
        boolLog = false;
        varargin(i) = [];
    elseif isequal(varargin{i},'add')
        boolAdd = true;
        varargin(i) = [];
    elseif isequal(varargin{i},'noadd')
        boolAdd = false;
        varargin(i) = [];
    elseif isequal(varargin{i},'forcefirst')
        boolForceFirst = true;
        varargin(i) = [];
    elseif isequal(varargin{i},'forcelast')
        boolForceLast = true;
        varargin(i) = [];
    elseif isequal(varargin{i},'nicemarkers')
        boolNiceMarkers = true;
        varargin(i) = [];
    elseif isequal(varargin{i},'xscale')
        varargin(i) = [];
        if strcmpi( varargin{i},'lin') | strcmpi( varargin{i},'linscale')
            boolLog = false;
        elseif strcmpi( varargin{i},'log')  | strcmpi( varargin{i},'logscale')
            boolLog = true;
        else
            error('Unrecognized scale argument');
        end
        varargin(i) = [];
    elseif isequal(varargin{i},'offset')
        varargin(i) = [];
        offsetValue = varargin{i};
        varargin(i) = [];
        %disp(['(in plotwithmarker) offsetValue = ' num2str(offsetValue)]);
    elseif isequal(varargin{i},'random')
        boolRandom = true;
        varargin(i) = [];
        randomValue = varargin{i};
        if randomValue<0 || randomValue >1
            error('randomValue must be in [0;1]');
        end
        varargin(i) = [];
        %disp(['(in plotwithmarker) randomValue = ' num2str(offsetValue)]);
    end
end



% Build the position of the markers
if boolRandom
    % The space is partly random
    xm = cumsum(1+randomValue*(rand(nbMarkers,1)-1));
    xm = xm-min(xm);
    xm = xm/max(xm);
else
    % Regular spacing
    xm = (offsetValue:1:nbMarkers)/nbMarkers;
end

% Add the first and last if required
if boolForceFirst && xm(1)~=0
    xm = [0 xm];
end
if boolForceLast && xm(1)~=1
    xm = [xm 1];
end

% Modify for logscale
if boolLog
    xm = xm*(log10(x(end))-log10(x(1)))+log10(x(1));
    xm = 10.^xm;
else
    xm = xm*(x(end)-x(1))+x(1);
end

% Build the y position of the markers
ym = zeros(size(xm));

for n=1:length(xm)
    % Find the points of x just before and after the marker
    i = find( (x(1:end-1)-xm(n)).*(x(2:end)-xm(n))<=0 );
    if ~isempty(i)
        % Interpolation
        i = i(1);
        d = (xm(n)-x(i))/(x(i+1)-x(i));
        ym(n) = (1-d)*y(i) + d*y(i+1);
    else
        % Take the closest point.
        if boolLog
            [dummy,i] = min(abs(x/xm(n)-1));
        else
            [dummy,i] = min(abs(x-xm(n)));
        end
        xm(n) = x(i);
        ym(n) = y(i);
    end
    if boolAdd
        x = [x(1:i) ; xm(n) ; x(i+1:end)];
        y = [y(1:i) ; ym(n) ; y(i+1:end)];
    end
end


% Plot the basic curve
p1 = plot(x,y,varargin{:});
% Remove all the markers.
set(p1,'marker','none');


% Plot the markers
p2 = plot(xm,ym,varargin{:});
% Remove the line
set(p2,'linestyle','none');




% Plot a line with markers.
% The length of the line is null, but it will
% be used for the legend.
pointeur = plot(xm(1),ym(1),varargin{:});

% Modify the color of the markers.
if boolNiceMarkers
    c = get(p1,'color');
    c = 1 - 0.5*(1-c);
    set(p2,'markerfacecolor',c);
    set(pointeur,'markerfacecolor',c);
end

% Set the hold as it was in the begining.
if ~boolHold
    hold off
end
