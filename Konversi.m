function varargout = Konversi(varargin)
% KONVERSI MATLAB code for Konversi.fig
%      KONVERSI, by itself, creates a new KONVERSI or raises the existing
%      singleton*.
%
%      H = KONVERSI returns the handle to a new KONVERSI or the handle to
%      the existing singleton*.
%
%      KONVERSI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KONVERSI.M with the given input arguments.
%
%      KONVERSI('Property','Value',...) creates a new KONVERSI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Konversi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Konversi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Konversi

% Last Modified by GUIDE v2.5 15-Dec-2024 21:33:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Konversi_OpeningFcn, ...
                   'gui_OutputFcn',  @Konversi_OutputFcn, ...
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


% --- Executes just before Konversi is made visible.
function Konversi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Konversi (see VARARGIN)

% Choose default command line output for Konversi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Konversi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Konversi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[nama_file1, nama_path1] = uigetfile(...
{'*.bmp; *.jpg', 'File Citra (*.bmp, *.jpg)'; 
 '*.bmp', 'File Bitmap (*.bmp)'; 
 '*.jpg', 'File Jpeg (*.jpg)'; 
 '*.*', 'Semua File (*.*)'}, ...
 'Buka Citra asli');

if ~isequal(nama_file1, 0)
    handles.data1 = imread(fullfile(nama_path1, nama_file1));
    guidata(hObject, handles);
    handles.current_data1 = handles.data1;
    axes(handles.axes1)
    imshow(handles.current_data1);
else
    return
end

info = imfinfo(fullfile(nama_path1, nama_file1));
set(handles.edit1, 'String', nama_file1);
set(handles.edit2, 'String', info.FileSize);
set(handles.edit3, 'String', info.Width);
set(handles.edit4, 'String', info.Height);
set(handles.edit5, 'String', info.BitDepth);
set(handles.edit6, 'String', info.ColorType);


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc  % Clears the command window
set(handles.edit1, 'String', '');  % Clears the text in edit box 1
set(handles.edit2, 'String', '');  % Clears the text in edit box 2
set(handles.edit3, 'String', '');  % Clears the text in edit box 3
set(handles.edit4, 'String', '');  % Clears the text in edit box 4
set(handles.edit5, 'String', '');  % Clears the text in edit box 5
set(handles.edit6, 'String', '');  % Clears the text in edit box 6

cla(handles.axes1, 'reset');  % Clears and resets the contents of axes 1
cla(handles.axes2, 'reset');  % Clears and resets the contents of axes 2


% --- Executes on button press in binary.
function binary_Callback(hObject, eventdata, handles)
% hObject    handle to binary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imageBiner = handles.data1;
gray = rgb2gray(imageBiner);  % Convert to grayscale
threshold = 0.5;             % Set a threshold value (0 to 1 for normalized grayscale)
bw = gray > threshold * 255; % Convert to binary (manual thresholding)

bwmap = zeros(2, 3);
bwmap(2, :) = 1;
axes(handles.axes2);
imshow(bw);
title('Citra Biner');
colormap(handles.axes2, bwmap);



% --- Executes on button press in Histogram.
function Histogram_Callback(hObject, eventdata, handles)
% hObject    handle to Histogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ColorType = get(handles.edit6, 'String');
figure;

switch ColorType
    case 'grayscale'
        % Flatten the grayscale image
        data_gray = handles.data1(:);
        % Compute histogram
        histogram_counts = histcounts(data_gray, 0:255);
        bar(0:254, histogram_counts);
        title('Histogram Intensitas Warna Grayscale');
        xlabel('Pixel Intensitas');
        ylabel('Frekuensi');
        
    case 'truecolor'
        % Red Channel
        subplot(3,1,1);
        data_red = handles.data1(:,:,1);
        histogram_counts_red = histcounts(data_red(:), 0:255);
        bar(0:254, histogram_counts_red);
        title('Histogram Intensitas Warna Merah');
        xlabel('Pixel Intensitas');
        ylabel('Frekuensi');
        
        % Green Channel
        subplot(3,1,2);
        data_green = handles.data1(:,:,2);
        histogram_counts_green = histcounts(data_green(:), 0:255);
        bar(0:254, histogram_counts_green);
        title('Histogram Intensitas Warna Hijau');
        xlabel('Pixel Intensitas');
        ylabel('Frekuensi');
        
        % Blue Channel
        subplot(3,1,3);
        data_blue = handles.data1(:,:,3);
        histogram_counts_blue = histcounts(data_blue(:), 0:255);
        bar(0:254, histogram_counts_blue);
        title('Histogram Intensitas Warna Biru');
        xlabel('Pixel Intensitas');
        ylabel('Frekuensi');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in grayscale.
function grayscale_Callback(hObject, eventdata, handles)
% hObject    handle to grayscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imagegray = handles.data1;
gray = rgb2gray(imagegray);
axes(handles.axes2);
imshow(gray);
title('Citra Grayscale');
