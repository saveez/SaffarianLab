function varargout = Tirf2Danalysis_60x_3_17_2017(varargin)
% TIRFDECONVOLUTION3D_061412V1 MATLAB code for TirfDeconvolution3D_061412V1.fig
%      TIRFDECONVOLUTION3D_061412V1, by itself, creates a new TIRFDECONVOLUTION3D_061412V1 or raises the existing
%      singleton*.
%
%      H = TIRFDECONVOLUTION3D_061412V1 returns the handle to a new TIRFDECONVOLUTION3D_061412V1 or the handle to
%      the existing singleton*.
%
%      TIRFDECONVOLUTION3D_061412V1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TIRFDECONVOLUTION3D_061412V1.M with the given input arguments.
%
%      TIRFDECONVOLUTION3D_061412V1('Property','Value',...) creates a new TIRFDECONVOLUTION3D_061412V1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TirfDeconvolution3D_061412V1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TirfDeconvolution3D_061412V1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TirfDeconvolution3D_061412V1

% Last Modified by GUIDE v2.5 17-Mar-2017 15:00:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Tirf2Danalysis_60x_3_17_2017_OpeningFcn, ...
                   'gui_OutputFcn',  @Tirf2Danalysis_60x_3_17_2017_OutputFcn, ...
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


% --- Executes just before TirfDeconvolution3D_061412V1 is made visible.
function Tirf2Danalysis_60x_3_17_2017_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TirfDeconvolution3D_061412V1 (see VARARGIN)

global namei nameii obj nframes shiftx shifty;
%objn number of objects, shiftxx yy are the differences in two color
%coordinates. lobj is the length of each object, sobj is the sorting status
%of the object, cobj is the class value of the object.
[namei,pathi]=uigetfile('*.tif','Channel1');
cd(pathi);
[nameii,pathi]=uigetfile('*.tif','Channel2');
obj=[];
nframes=600;
I=imread(namei,1);
I2=imread(nameii,1);
shiftx=0;
shifty=0;
size(I);
axes(handles.image1);
min1=min(min(I));
max1=max(max(I));
set(handles.minimum,'string', min1);
set(handles.maximum,'string', max1);
imshow(I,[min1,max1]);
impixelinfo(handles.image1);
size(I2);
axes(handles.image2);
min2=min(min(I2));
max2=max(max(I2));
set(handles.minimum2,'string', min2);
set(handles.maximum2,'string', max2);
imshow(I2,[min2,max2]);

% Choose default command line output for TirfDeconvolution3D_061412V1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TirfDeconvolution3D_061412V1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Tirf2Danalysis_60x_3_17_2017_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in Addparticle.
function Addparticle_Callback(hObject, eventdata, handles)
% hObject    handle to Addparticle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% get(handles.startparticlecoordinates,'string')
global namei nameii  obj nframes shiftx shifty
[m,l]=size(obj);
set(handles.objectnumber, 'string', num2str(l+1));
start=get(handles.startparticlecoordinates,'string');
[position,count]=sscanf(start,'%d %d %d');
for i=1:nframes
    obj(l+1).intensity(i)=0;
    obj(l+1).intensity2(i)=0;
    obj(l+1).x(i)=position(1);
    obj(l+1).y(i)=position(2);
end
temp=[];
obj(l+1).x2=obj(l+1).x + shiftx;
obj(l+1).y2=obj(l+1).y + shifty;
for i=position(3):nframes
    I=imread(namei,i);
    I2=imread(nameii,i);
    [obj(l+1).intensity(i), obj(l+1).x(i), obj(l+1).y(i)]=optimizeposition36(I,obj(l+1).x(i-1),obj(l+1).y(i-1));
    [obj(l+1).intensity2(i), obj(l+1).x2(i), obj(l+1).y2(i)]=optimizeposition36(I2,obj(l+1).x(i-1),obj(l+1).y(i-1));
end
axes(handles.intensityplot);
plot(obj(l+1).intensity);
hold on;
plot(obj(l+1).intensity2,'Color','red');
hold off;


function startparticlecoordinates_Callback(hObject, eventdata, handles)
% hObject    handle to startparticlecoordinates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of startparticlecoordinates as text
%        str2double(get(hObject,'String')) returns contents of startparticlecoordinates as a double


% --- Executes during object creation, after setting all properties.
function startparticlecoordinates_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startparticlecoordinates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function endparticlecooredinates_Callback(hObject, eventdata, handles)
% hObject    handle to endparticlecooredinates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of endparticlecooredinates as text
%        str2double(get(hObject,'String')) returns contents of endparticlecooredinates as a double


% --- Executes during object creation, after setting all properties.
function endparticlecooredinates_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endparticlecooredinates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frame_Callback(hObject, eventdata, handles)
% hObject    handle to frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frame as text
%        str2double(get(hObject,'String')) returns contents of frame as a double
global namei nameii obj
v=int16(str2double(get(hObject,'String')));
v
I=imread(namei,v);
axes(handles.image1);
xl=xlim(handles.image1);
yl=ylim(handles.image1);
min1=str2num(get(handles.minimum,'string'));
max1=str2num(get(handles.maximum,'string'));
imshow(I, [min1, max1]);
set(gca,'XLim',xl,'YLim',yl);
xl
I2=imread(nameii,v);
axes(handles.image2);
xl2=xlim(handles.image2);
yl2=ylim(handles.image2);
min2=str2num(get(handles.minimum2,'string'));
max2=str2num(get(handles.maximum2,'string'));
imshow(I2, [min2, max2]);
set(gca,'XLim',xl2,'YLim',yl2);

impixelinfo(handles.image1);
i=str2num(get(handles.objectnumber,'string'));
if i>0
    [x3,y3]=size(obj);

    axes(handles.image2);
    hold on;
    for j=1:y3
    plot(obj(j).x2(v),obj(j).y2(v),'marker','s','MarkerEdgeColor','g','markersize',2); 
    end
    plot(obj(i).x2(v),obj(i).y2(v),'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x2(v)+3,obj(i).y2(v)+3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x2(v)+3,obj(i).y2(v)-3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x2(v)-3,obj(i).y2(v)+3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x2(v)-3,obj(i).y2(v)-3,'marker','s','MarkerEdgeColor','r','markersize',2);
    hold off;
    axes(handles.intensityplot);
    plot(obj(i).intensity);
    hold on;
    plot(obj(i).intensity2,'Color','red');
    scatter(v,obj(i).intensity(v));
    hold off;
    axes(handles.image1);
    hold on;
    for j=1:y3
    plot(obj(j).x(v),obj(j).y(v),'marker','s','MarkerEdgeColor','g','markersize',2); 
    end
    plot(obj(i).x(v),obj(i).y(v),'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x(v)+3,obj(i).y(v)+3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x(v)+3,obj(i).y(v)-3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x(v)-3,obj(i).y(v)+3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x(v)-3,obj(i).y(v)-3,'marker','s','MarkerEdgeColor','r','markersize',2);
    hold off;
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function frame_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function particlenumber_Callback(hObject, eventdata, handles)
% hObject    handle to particlenumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of particlenumber as text
%        str2double(get(hObject,'String')) returns contents of particlenumber as a double


% --- Executes during object creation, after setting all properties.
function particlenumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to particlenumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in zoomon1.
function zoomon1_Callback(hObject, eventdata, handles)
% hObject    handle to zoomon1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
zoom on;

% --- Executes on button press in zoomoff1.
function zoomoff1_Callback(hObject, eventdata, handles)
% hObject    handle to zoomoff1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
zoom off;



function objectnumber_Callback(hObject, eventdata, handles)
% hObject    handle to objectnumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of objectnumber as text
%        str2double(get(hObject,'String')) returns contents of objectnumber as a double


% --- Executes during object creation, after setting all properties.
function objectnumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to objectnumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global obj
name=get(handles.filename,'string');
clear handles hObject;
save(name);

% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global obj
[name,pathf]=uigetfile('*.mat','workspace');
cd(pathf);
load(name);
[m,l]=size(obj);
set(handles.objectnumber,'string',num2str(l));


function filename_Callback(hObject, eventdata, handles)
% hObject    handle to filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filename as text
%        str2double(get(hObject,'String')) returns contents of filename as a double


% --- Executes during object creation, after setting all properties.
function filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Nextframe.
function Nextframe_Callback(hObject, eventdata, handles)
% hObject    handle to Nextframe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global namei nameii obj
v=int16(str2num(get(handles.frame,'String')));
v=v+1;
I=imread(namei,v);
axes(handles.image1);
xl=xlim(handles.image1);
yl=ylim(handles.image1);
min1=str2num(get(handles.minimum,'string'));
max1=str2num(get(handles.maximum,'string'));
imshow(I, [min1, max1]);
set(gca,'XLim',xl,'YLim',yl);
xl
I2=imread(nameii,v);
axes(handles.image2);
xl2=xlim(handles.image2);
yl2=ylim(handles.image2);
min2=str2num(get(handles.minimum2,'string'));
max2=str2num(get(handles.maximum2,'string'));
imshow(I2, [min2, max2]);
set(gca,'XLim',xl2,'YLim',yl2);

impixelinfo(handles.image1);
i=str2num(get(handles.objectnumber,'string'));
if i>0
    [x3,y3]=size(obj);

    axes(handles.image2);
    hold on;
    for j=1:y3
    plot(obj(j).x2(v),obj(j).y2(v),'marker','s','MarkerEdgeColor','g','markersize',2); 
    end
    plot(obj(i).x2(v),obj(i).y2(v),'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x2(v)+3,obj(i).y2(v)+3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x2(v)+3,obj(i).y2(v)-3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x2(v)-3,obj(i).y2(v)+3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x2(v)-3,obj(i).y2(v)-3,'marker','s','MarkerEdgeColor','r','markersize',2);
    hold off;
    axes(handles.intensityplot);
    plot(obj(i).intensity);
    hold on;
    plot(obj(i).intensity2,'Color','red');
    scatter(v,obj(i).intensity(v));
    hold off;
    axes(handles.image1);
    hold on;
    for j=1:y3
    plot(obj(j).x(v),obj(j).y(v),'marker','s','MarkerEdgeColor','g','markersize',2); 
    end
    plot(obj(i).x(v),obj(i).y(v),'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x(v)+3,obj(i).y(v)+3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x(v)+3,obj(i).y(v)-3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x(v)-3,obj(i).y(v)+3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x(v)-3,obj(i).y(v)-3,'marker','s','MarkerEdgeColor','r','markersize',2);
    hold off;
end
v=num2str(v);
set(handles.frame,'string',v);
guidata(hObject, handles);


% --- Executes on button press in PreviousFrame.
function PreviousFrame_Callback(hObject, eventdata, handles)
% hObject    handle to PreviousFrame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global namei nameii obj
v=int16(str2num(get(handles.frame,'String')));
v=v-1;
I=imread(namei,v);
axes(handles.image1);
xl=xlim(handles.image1);
yl=ylim(handles.image1);
min1=str2num(get(handles.minimum,'string'));
max1=str2num(get(handles.maximum,'string'));
imshow(I, [min1, max1]);
set(gca,'XLim',xl,'YLim',yl);
xl
I2=imread(nameii,v);
axes(handles.image2);
xl2=xlim(handles.image2);
yl2=ylim(handles.image2);
min2=str2num(get(handles.minimum2,'string'));
max2=str2num(get(handles.maximum2,'string'));
imshow(I2, [min2, max2]);
set(gca,'XLim',xl2,'YLim',yl2);

impixelinfo(handles.image1);
i=str2num(get(handles.objectnumber,'string'));
if i>0
    [x3,y3]=size(obj);

    axes(handles.image2);
    hold on;
    for j=1:y3
    plot(obj(j).x2(v),obj(j).y2(v),'marker','s','MarkerEdgeColor','g','markersize',2); 
    end
    plot(obj(i).x2(v),obj(i).y2(v),'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x2(v)+3,obj(i).y2(v)+3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x2(v)+3,obj(i).y2(v)-3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x2(v)-3,obj(i).y2(v)+3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x2(v)-3,obj(i).y2(v)-3,'marker','s','MarkerEdgeColor','r','markersize',2);
    hold off;
    axes(handles.intensityplot);
    plot(obj(i).intensity);
    hold on;
    plot(obj(i).intensity2,'Color','red');
    scatter(v,obj(i).intensity(v));
    hold off;
    axes(handles.image1);
    hold on;
    for j=1:y3
    plot(obj(j).x(v),obj(j).y(v),'marker','s','MarkerEdgeColor','g','markersize',2); 
    end
    plot(obj(i).x(v),obj(i).y(v),'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x(v)+3,obj(i).y(v)+3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x(v)+3,obj(i).y(v)-3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x(v)-3,obj(i).y(v)+3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x(v)-3,obj(i).y(v)-3,'marker','s','MarkerEdgeColor','r','markersize',2);
    hold off;
end
v=num2str(v);
set(handles.frame,'string',v);
guidata(hObject, handles);


% --- Executes on button press in deleteObj.
function deleteObj_Callback(hObject, eventdata, handles)
% hObject    handle to deleteObj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global namei obj
i=str2num(get(handles.objectnumber,'string'))
obj(i)=[];
i=num2str(i-1);
set(handles.objectnumber,'string',i);
guidata(hObject, handles);


% --- Executes on button press in NextObj.
function NextObj_Callback(hObject, eventdata, handles)
% hObject    handle to NextObj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global namei obj
v=int16(str2num(get(handles.frame,'String')));
I=imread(namei,v);
axes(handles.image1);
xl=xlim(handles.image1);
yl=ylim(handles.image1);
min1=str2num(get(handles.minimum,'string'));
max1=str2num(get(handles.maximum,'string'));
imshow(I, [min1, max1]);
set(gca,'XLim',xl,'YLim',yl);
impixelinfo(handles.image1);
[x3,y3]=size(obj);
i=str2num(get(handles.objectnumber,'string'))+1;
if i> y3
    i=y3;
end
if i>0
    hold on;
    for j=1:y3
    plot(obj(j).x(v),obj(j).y(v),'marker','s','MarkerEdgeColor','g','markersize',2); 
    end
    plot(obj(i).x(v),obj(i).y(v),'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x(v)+3,obj(i).y(v)+3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x(v)+3,obj(i).y(v)-3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x(v)-3,obj(i).y(v)+3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(i).x(v)-3,obj(i).y(v)-3,'marker','s','MarkerEdgeColor','r','markersize',2);
    hold off;
    axes(handles.intensityplot);
    plot(obj(i).intensity);
    hold on;
    plot(obj(i).intensity2,'Color','red');
    scatter(v,obj(i).intensity(v));
    hold off;
end
hold off;
i=num2str(i);
set(handles.objectnumber,'string',i)
guidata(hObject, handles);


% --- Executes on button press in Previousobj.
function Previousobj_Callback(hObject, eventdata, handles)
% hObject    handle to Previousobj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global namei obj
v=int16(str2num(get(handles.frame,'String')));
I=imread(namei,v);
axes(handles.image1);
xl=xlim(handles.image1);
yl=ylim(handles.image1);
min1=str2num(get(handles.minimum,'string'));
max1=str2num(get(handles.maximum,'string'));
imshow(I, [min1, max1]);
set(gca,'XLim',xl,'YLim',yl);
impixelinfo(handles.image1);
[x3,y3]=size(obj);
i=str2num(get(handles.objectnumber,'string'))-1;
if i<1
    i=0;
end
if i>0
    hold on;
    for j=1:y3
    plot(obj(j).x(v),obj(j).y(v),'marker','s','MarkerEdgeColor','g','markersize',2); 
    end
    plot(obj(i).x(v),obj(i).y(v),'marker','s','MarkerEdgeColor','r','markersize',2);
    hold off;
    axes(handles.intensityplot);
    plot(obj(i).intensity);
    hold on;
    plot(obj(i).intensity2,'Color','red');
    scatter(v,obj(i).intensity(v));
    hold off;
end
hold off;
i=num2str(i);
set(handles.objectnumber,'string',i)
guidata(hObject, handles);



function minimum_Callback(hObject, eventdata, handles)
% hObject    handle to minimum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global namei obj
v=int16(str2num(get(handles.frame,'String')));
I=imread(namei,v);
axes(handles.image1);
min1=str2num(get(hObject,'string'));
max1=str2num(get(handles.maximum,'string'));
imshow(I, [min1, max1]);
set(gca,'XLim',xl,'YLim',yl);
% Hints: get(hObject,'String') returns contents of minimum as text
%        str2double(get(hObject,'String')) returns contents of minimum as a double


% --- Executes during object creation, after setting all properties.
function minimum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minimum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maximum_Callback(hObject, eventdata, handles)
% hObject    handle to maximum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global namei obj
v=int16(str2num(get(handles.frame,'String')));
I=imread(namei,v);
axes(handles.image1);
min1=str2num(get(handles.minimum,'string'));
max1=str2num(get(hObject,'string'));
imshow(I, [min1, max1]);
set(gca,'XLim',xl,'YLim',yl);
% Hints: get(hObject,'String') returns contents of maximum as text
%        str2double(get(hObject,'String')) returns contents of maximum as a double


% --- Executes during object creation, after setting all properties.
function maximum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maximum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in correctpoint.
function correctpoint_Callback(hObject, eventdata, handles)
% hObject    handle to correctpoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global namei nameii nameiii obj nframes shiftx shifty
v=int16(str2num(get(handles.frame,'String')));
I=imread(namei,v);
I2=imread(nameii,v);
axes(handles.image1);
[x,y,p]=impixel;
posx=uint16(mean(x));
posy=uint16(mean(y));
l=str2num(get(handles.objectnumber,'string'));
[obj(l).intensity(v), obj(l).x(v), obj(l).y(v)]=optimizeposition36(I,posx,posy);
[obj(l).intensity2(v), obj(l).x2(v), obj(l).y2(v)]=optimizeposition36(I2,posx+shiftx,posy+shifty);
[x3,y3]=size(obj);
    hold on;
    for j=1:y3
    plot(obj(j).x(v),obj(j).y(v),'marker','s','MarkerEdgeColor','g','markersize',2); 
    end
    plot(obj(l).x(v),obj(l).y(v),'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(l).x(v)+3,obj(l).y(v)+3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(l).x(v)+3,obj(l).y(v)-3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(l).x(v)-3,obj(l).y(v)+3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(l).x(v)-3,obj(l).y(v)-3,'marker','s','MarkerEdgeColor','r','markersize',2);
    hold off;

    axes(handles.image2);
    hold on;
    for j=1:y3
    plot(obj(j).x2(v),obj(j).y2(v),'marker','s','MarkerEdgeColor','g','markersize',2); 
    end
    plot(obj(l).x2(v),obj(l).y2(v),'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(l).x2(v)+3,obj(l).y2(v)+3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(l).x2(v)+3,obj(l).y2(v)-3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(l).x2(v)-3,obj(l).y2(v)+3,'marker','s','MarkerEdgeColor','r','markersize',2);
    plot(obj(l).x2(v)-3,obj(l).y2(v)-3,'marker','s','MarkerEdgeColor','r','markersize',2);
    hold off;
    
    axes(handles.intensityplot);
    plot(obj(l).intensity);
    hold on;
    plot(obj(l).intensity2,'Color','red');
    scatter(v,obj(l).intensity(v));
    hold off;



function minimum2_Callback(hObject, eventdata, handles)
% hObject    handle to minimum2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minimum2 as text
%        str2double(get(hObject,'String')) returns contents of minimum2 as a double


% --- Executes during object creation, after setting all properties.
function minimum2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minimum2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maximum2_Callback(hObject, eventdata, handles)
% hObject    handle to maximum2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maximum2 as text
%        str2double(get(hObject,'String')) returns contents of maximum2 as a double


% --- Executes during object creation, after setting all properties.
function maximum2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maximum2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
