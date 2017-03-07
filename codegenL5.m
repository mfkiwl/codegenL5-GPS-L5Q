function code = codegenL5(sv,fs,type)
%CODEGENL5 Generates L5I or L5Q code.
%   CODE = CODEGENL5(SV,FS,TYPE) generates a code CODE for the
%   satellite number SV with FS number of samples per chip for the
%   type TYPE. Supported types are:
%       
%       'L5I'                       L5I code
%       'L5Q' and (otherwise)       L5Q code
% 
% Examples:
%
% code = codegenL5(1,10,'L5I')
%       generates a L5I code for SV number 1 with 10 chips per code
%
% Considering that the L5 codes last 1 ms and have 10230 chips, the
% resulting sampling frequency is 10.23 MHz. It is possible to generate a
% code sampled at a desired frequency by scaling the FS value as
% DESIRED_FS_IN_MHZ/10.23 or DESIRED_FS_IN_HZ/10.23e6 as the example:
%
% code = codegenL5(1,50/10.23,'L5I')
%       generates a L5I code for the SV number 1 with 50 MHz sample ratio
%
% Revision History
% rev 1.0 Raul Onrubia 30-06-2014   Initial Release
%
%   Author: Raul Onrubia
%   Contact: onrubia (at) tsc.upc.edu
%   Github: https://github.com/onrubia/codegenL5
%
% Copyright (C) 2014 Raul Onrubia
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.
%     

if fs<1
    fs = 1;
    display('FS below the minimum, set to 1 (10.23 MHz)');
end

if (sv<1)||(sv>64)||(~isnumeric(sv))
    sv = 1;
    display('Incorrect SV value or type, set to 1');
end

I5is = [ 0 1 0 1 0 1 1 1 0 0 1 0 0
    1 1 0 0 0 0 0 1 1 0 1 0 1
    0 1 0 0 0 0 0 0 0 1 0 0 0
    1 0 1 1 0 0 0 1 0 0 1 1 0
    1 1 1 0 1 1 1 0 1 0 1 1 1
    0 1 1 0 0 1 1 1 1 1 0 1 0
    1 0 1 0 0 1 0 0 1 1 1 1 1
    1 0 1 1 1 1 0 1 0 0 1 0 0
    1 1 1 1 1 0 0 1 0 1 0 1 1
    0 1 1 1 1 1 1 0 1 1 1 1 0
    0 0 0 0 1 0 0 1 1 1 0 1 0
    1 1 1 0 0 1 1 1 1 1 0 0 1
    0 0 0 1 1 1 0 0 1 1 1 0 0
    0 1 0 0 0 0 0 1 0 0 1 1 1
    0 1 1 0 1 0 1 0 1 1 0 1 0
    0 0 0 1 1 1 1 0 0 1 0 0 1
    0 1 0 0 1 1 0 0 0 1 1 1 1
    1 1 1 1 0 0 0 0 1 1 1 1 0
    1 1 0 0 1 0 0 0 1 1 1 1 1
    0 1 1 0 1 0 1 1 0 1 1 0 1
    0 0 1 0 0 0 0 0 0 1 0 0 0
    1 1 1 0 1 1 1 1 0 1 1 1 1
    1 0 0 0 0 1 1 1 1 1 1 1 0
    1 1 0 0 0 1 0 1 1 0 1 0 0
    1 1 0 1 0 0 1 1 0 1 1 0 1
    1 0 1 0 1 1 0 0 1 0 1 1 0
    0 1 0 1 0 1 1 0 1 1 1 1 0
    0 1 1 1 1 0 1 0 1 0 1 1 0
    0 1 0 1 1 1 1 1 0 0 0 0 1
    1 0 0 0 0 1 0 1 1 0 1 1 1
    0 0 0 1 0 1 0 0 1 1 1 1 0
    0 0 0 0 0 1 0 1 1 1 0 0 1
    1 1 0 1 0 1 0 0 0 0 0 0 1
    1 1 0 1 1 1 1 1 1 1 0 0 1
    1 1 1 1 0 1 1 0 1 1 1 0 0
    1 0 0 1 0 1 1 0 0 1 0 0 0
    0 0 1 1 0 1 0 0 1 0 0 0 0
    0 1 0 1 1 0 0 0 0 0 1 1 0
    1 0 0 1 0 0 1 1 0 0 1 0 1
    1 1 0 0 1 1 1 0 0 1 0 1 0
    0 1 1 1 0 1 1 0 1 1 0 0 1
    0 0 1 1 1 0 1 1 0 1 1 0 0
    0 0 1 1 0 1 1 1 1 1 0 1 0
    1 0 0 1 0 1 1 0 1 0 0 0 1
    1 0 0 1 0 1 0 1 1 1 1 1 1
    0 1 1 1 0 0 0 1 1 1 1 0 1
    0 0 0 0 0 0 1 0 0 0 1 0 0
    1 0 0 0 1 0 1 0 1 0 0 0 1
    0 0 1 1 0 1 0 0 0 1 0 0 1
    1 0 0 0 1 1 1 1 1 0 0 0 1
    1 0 1 1 1 0 0 1 0 1 0 0 1
    0 1 0 0 1 0 1 0 1 1 0 1 0
    0 0 0 0 0 0 1 0 0 0 0 1 0
    0 1 1 0 0 0 1 1 0 1 1 1 0
    0 0 0 0 0 1 1 0 0 1 1 1 0
    1 1 1 0 1 1 1 0 1 1 1 1 0
    0 0 0 1 0 0 0 0 1 0 0 1 1
    0 0 0 0 0 1 0 1 0 0 0 0 1
    0 1 0 0 0 0 1 1 0 0 0 0 1
    0 1 0 0 1 0 1 0 0 1 0 0 1
    0 0 1 1 1 1 0 0 1 1 1 1 0
    1 0 1 1 0 0 0 1 1 0 0 0 1
    0 1 0 1 1 1 1 0 0 1 0 1 1 ];

Q5is = [ 1 0 0 1 0 1 1 0 0 1 1 0 0
    0 1 0 0 0 1 1 1 1 0 1 1 0
    1 1 1 1 0 0 0 1 0 0 0 1 1
    0 0 1 1 1 0 1 1 0 1 0 1 0
    0 0 1 1 1 1 0 1 1 0 0 1 0
    0 1 0 1 0 1 0 1 0 1 0 0 1
    1 1 1 1 1 1 0 0 0 0 0 0 1
    0 1 1 0 1 0 1 1 0 1 0 0 0
    1 0 1 1 1 0 1 0 0 0 0 1 1
    0 0 1 0 0 1 0 0 0 0 1 1 0
    0 0 0 1 0 0 0 0 0 0 1 0 1
    0 1 0 1 0 1 1 0 0 0 1 0 1
    0 1 0 0 1 1 0 1 0 0 1 0 1
    1 0 1 0 0 0 0 1 1 1 1 1 1
    1 0 1 1 1 1 0 0 0 1 1 1 1
    1 1 0 1 0 0 1 0 1 1 1 1 1
    1 1 1 0 0 1 1 0 0 1 0 0 0
    1 0 1 1 0 1 1 1 0 0 1 0 0
    0 0 1 1 0 0 1 0 1 1 0 1 1
    1 1 0 0 0 0 1 1 1 0 0 0 1
    0 1 1 0 1 1 0 0 1 0 0 0 0
    0 0 1 0 1 1 0 0 0 1 1 1 0
    1 0 0 0 1 0 1 1 1 1 1 0 1
    0 1 1 0 1 1 1 1 1 0 0 1 1
    0 1 0 0 0 1 0 0 1 1 0 1 1
    0 1 0 1 0 1 0 1 1 1 1 0 0
    1 0 0 0 0 1 1 1 1 1 0 1 0
    1 1 1 1 1 0 1 0 0 0 0 1 0
    0 1 0 1 0 0 0 1 0 0 1 0 0
    1 0 0 0 0 0 1 1 1 1 0 0 1
    0 1 0 1 1 1 1 1 0 0 1 0 1
    1 0 0 1 0 0 0 1 0 1 0 1 0
    1 0 1 1 0 0 1 0 0 0 1 0 0
    1 1 1 1 0 0 1 0 0 0 1 0 0
    0 1 1 0 0 1 0 1 1 0 0 1 1
    0 0 1 1 1 1 0 1 0 1 1 1 1
    0 0 1 0 0 1 1 0 1 0 0 0 1
    1 1 1 1 1 1 0 0 1 1 1 0 1
    0 1 0 1 0 1 0 0 1 1 1 1 1
    1 0 0 0 1 1 0 1 0 1 0 1 0
    0 0 1 0 1 1 1 1 0 0 1 0 0
    1 0 1 1 0 0 0 1 0 0 0 0 0
    0 0 1 1 0 0 1 0 1 1 0 0 1
    1 0 0 0 1 0 0 1 0 1 0 0 0
    0 0 0 0 0 0 1 1 1 1 1 1 0
    0 0 0 0 0 0 0 0 1 0 0 1 1
    0 1 0 1 1 1 0 0 1 1 1 1 0
    0 0 0 1 0 0 1 0 0 0 1 1 1
    0 0 1 1 1 1 0 0 0 0 1 0 0
    0 1 0 0 1 0 1 0 1 1 1 0 0
    0 0 1 0 1 0 0 0 1 1 1 1 1
    1 1 0 1 1 1 0 0 1 1 0 0 1
    0 0 1 1 1 1 1 1 0 1 1 1 1
    1 1 0 0 1 0 0 1 1 0 1 1 1
    1 0 0 1 0 0 1 1 0 0 1 1 0
    0 1 0 0 0 1 0 0 1 1 0 0 1
    0 0 0 0 0 0 0 0 0 1 0 1 1
    0 0 0 0 0 0 1 1 0 1 1 1 1
    0 1 0 1 1 0 1 1 0 1 1 1 1
    0 1 0 0 1 0 0 0 0 1 1 0 1
    1 1 0 1 1 0 0 1 0 1 0 1 1
    1 0 1 0 1 1 1 0 0 0 1 0 0
    0 0 1 0 0 0 1 1 0 1 0 0 1 ];

n = 13;
L = 10230;

XAs = [ 0 0 0 0 0 0 0 0 1 1 0 1 1 ];
XBIs = [ 1 0 1 1 0 1 1 1 0 0 0 1 1 ];
XBQs = [ 1 0 1 1 0 1 1 1 0 0 0 1 1 ];

XA = ones(1,n);
XBI = I5is(sv,:);
XBQ = Q5is(sv,:);

XI = zeros(1,ceil(L*fs));
XQ = zeros(1,ceil(L*fs));

decode = [ 1 1 1 1 1 1 1 1 1 1 1 0 1];

for ii = 1:L
    
    XI(ii) = mod(XA(n) + XBI(n),2);
    XQ(ii) = mod(XA(n) + XBQ(n),2);
    
    if isequal(XA,decode)
        XA = ones(1,n);
    else
        XA = [ mod(sum(XA.*XAs),2) XA(1:n-1) ];
    end
    XBI = [ mod(sum(XBI.*XBIs),2) XBI(1:n-1) ];
    XBQ = [ mod(sum(XBQ.*XBQs),2) XBQ(1:n-1) ];
    
end

if fs~=1
    
    tempi = zeros(1, ceil(L*fs));
    tempq = zeros(1, ceil(L*fs));
    
    index = 0;
    for cnt = 1/fs:1/fs:L
        index = index + 1;
        if ceil(cnt) > L
            tempi(index) = XI(L);
            tempq(index) = XQ(L);
        else
            tempi(index) = XI(ceil(cnt));
            tempq(index) = XQ(ceil(cnt));
        end
    end
    XI = tempi;
    XQ = tempq;
end

XI = 2*XI-1;
XQ = 2*XQ-1;

if strcmp(type,'L5I')
    code = XI;
else
    code = XQ;
end

end