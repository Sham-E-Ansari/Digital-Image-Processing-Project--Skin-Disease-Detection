function varargout = untitled1(varargin)
% UNTITLED1 MATLAB code for untitled1.fig
%      UNTITLED1, by itself, creates a new UNTITLED1 or raises the existing
%      singleton*.
%
%      H = UNTITLED1 returns the handle to a new UNTITLED1 or the handle to
%      the existing singleton*.
%
%      UNTITLED1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED1.M with the given input arguments.
%
%      UNTITLED1('Property','Value',...) creates a new UNTITLED1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled1

% Last Modified by GUIDE v2.5 15-Apr-2019 22:31:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled1_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled1_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before untitled1 is made visible.
function untitled1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled1 (see VARARGIN)

% Choose default command line output for untitled1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
function setGlobalName(n)
global name
name = n;
function n = getGlobalName()
global name
 n= name;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Filename,Pathname]= uigetfile('*.*','File Selector');

name = strcat(Pathname,Filename);
setGlobalName(name);
I=imread(name);
I= imresize(I,[256,256]);
axes(handles.axes1);
imshow(I);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
name = getGlobalName();
I = imread(name);
axes(handles.axes1);
imshow(I);
title('Original Image');


I = rgb2gray(I);
I = imresize(I,[256,256]);
b = imsharpen(I,'Radius',2,'Amount',1,'Threshold',0.5);
b = medfilt2(b);

axes(handles.axes2);
imshow(b);
title('After Median Filter')

Kaverage = filter2(fspecial('average',3),b)/255;
axes(handles.axes5);
imshow(Kaverage);
title('After Mean Filter');
im = im2bw(Kaverage);

mask = zeros(size(im));
mask( 110: end-110,110:end-110)=1;

B = activecontour(im,mask,200);
axes(handles.axes3);
imshow(B);
title('Active Contour');


B=1-B;
B = bwareaopen(B,4000);
axes(handles.axes4);
imshow(B);

title('Detection');

if(any(B(:)))
   set(handles.text5,'String','Detected');
else
    set(handles.text5,'String','Not Detected');
end
bw_perim = bwperim(B);
overlay1 = imoverlay(I,bw_perim, [.3 1 .3]);

axes(handles.axes6);
imshow(overlay1);
title('Overlay');
