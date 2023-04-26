function varargout = morsetranslator(varargin)
% MORSETRANSLATOR MATLAB code for morsetranslator.fig
%      MORSETRANSLATOR, by itself, creates a new MORSETRANSLATOR or raises the existing
%      singleton*.
%
%      H = MORSETRANSLATOR returns the handle to a new MORSETRANSLATOR or the handle to
%      the existing singleton*.
%
%      MORSETRANSLATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MORSETRANSLATOR.M with the given input arguments.
%
%      MORSETRANSLATOR('Property','Value',...) creates a new MORSETRANSLATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before morsetranslator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to morsetranslator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help morsetranslator

% Last Modified by GUIDE v2.5 23-Apr-2021 22:41:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @morsetranslator_OpeningFcn, ...
                   'gui_OutputFcn',  @morsetranslator_OutputFcn, ...
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


% --- Executes just before morsetranslator is made visible.
function morsetranslator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to morsetranslator (see VARARGIN)

% Choose default command line output for morsetranslator
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%default background color
set ( gcf, 'Color', [0 0 0] )

%additional image on the axes
A = imread ('morsecode.png'); 
imshow(A)

% UIWAIT makes morsetranslator wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = morsetranslator_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in encode_pushbutton.
function encode_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to encode_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
engmsg=get(handles.engmsg_input,'string');

%translate starts here!
morse  = {'-----','.----','..---','...--','....-','.....','-....','--...','---..','----.','.-','-...','-.-.','-..','.','..-.','--.','....','..','.---','-.-','.-..','--','-.','---','.--.','--.-','.-.','...','-','..-','...-','.--','-..-','-.--','--..','/'}; 
letter = ['0':'9','A':'Z','_'];
[X,Y] = ismember(upper(engmsg),letter);
if not(X);
    errordlg('You have entered an invalid character','ERROR');% error dialog
    set(handles.morsecode_output,'string','INVALID');
else    
morseoutput=sprintf(' %s',morse{Y(X)})
set(handles.morsecode_output,'string',morseoutput);
end

function engmsg_input_Callback(hObject, eventdata, handles)
% hObject    handle to engmsg_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of engmsg_input as text
%        str2double(get(hObject,'String')) returns contents of engmsg_input as a double
engmsg=get(hObject,'string');
handles.engmsg=engmsg;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function engmsg_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to engmsg_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function morsecode_output_Callback(hObject, eventdata, handles)
% hObject    handle to morsecode_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of morsecode_output as text
%        str2double(get(hObject,'String')) returns contents of morsecode_output as a double

% --- Executes on button press in decode_pushbutton.
function decode_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to decode_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
morsecode=get(handles.morsecode_output,'string');

%translate starts here!
morsemsg = strsplit(morsecode, ' ');
morsemsg(cellfun(@isempty, morsemsg)) = []
morse  = {'-----','.----','..---','...--','....-','.....','-....','--...','---..','----.','.-','-...','-.-.','-..','.','..-.','--.','....','..','.---','-.-','.-..','--','-.','---','.--.','--.-','.-.','...','-','..-','...-','.--','-..-','-.--','--..','/'}; 
letter = ['0':'9','A':'Z','_'];
[X,Y] = ismember(morsemsg,morse);
if not(X);
    errordlg('You have entered an invalid character','ERROR');%error dialog
    set(handles.engmsg_input,'string','INVALID');
else    
engoutput = letter(Y(X))
set(handles.engmsg_input,'string',engoutput);
end

% --- Executes during object creation, after setting all properties.
function morsecode_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to morsecode_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%close program button on the GUI interface

% --- Executes on button press in closebutton.
function closebutton_Callback(hObject, eventdata, handles)
% hObject    handle to closebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq(); 

%save button on the toolbar

% --------------------------------------------------------------------
function savebutton_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to savebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA
set(gcf, 'PaperPositionMode', 'auto'); %save GUI based on its size
set(gcf, 'InvertHardCopy', 'off'); %allows user to save the GUI interface based on their preference of color 
saveas(gcf,'MyTranslation.png')

%--------------------------UI menu------------------------------------

% --------------------------------------------------------------------
function menu_Callback(hObject, eventdata, handles)
% hObject    handle to menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Options for backgroundcolor

% --------------------------------------------------------------------
function color_Callback(hObject, eventdata, handles)
% hObject    handle to color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function black_Callback(hObject, eventdata, handles)
% hObject    handle to black (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( gcf, 'Color', [0 0 0] )

% --------------------------------------------------------------------
function blue_Callback(hObject, eventdata, handles)
% hObject    handle to blue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( gcf, 'Color', [0.5 0.8 0.9] )

% --------------------------------------------------------------------
function green_Callback(hObject, eventdata, handles)
% hObject    handle to green (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( gcf, 'Color', [0.1 0.7 0.5] )

% --------------------------------------------------------------------
function orange_Callback(hObject, eventdata, handles)
% hObject    handle to orange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( gcf, 'Color', [0.9 0.5 0] )

% --------------------------------------------------------------------
function pink_Callback(hObject, eventdata, handles)
% hObject    handle to pink (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( gcf, 'Color', [1 0.5 0.6] )

%option to save GUI

% --------------------------------------------------------------------
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(gcf, 'PaperPositionMode', 'auto');
set(gcf, 'InvertHardCopy', 'off');
saveas(gcf,'MyTranslation.png')

%option to close the program

% --------------------------------------------------------------------
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq(); 

%---------------------------------------------------------------------

%UI context menu (background color)

% --------------------------------------------------------------------
function blackcolor_Callback(hObject, eventdata, handles)
% hObject    handle to blackcolor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( gcf, 'Color', [0 0 0] )

% --------------------------------------------------------------------
function bluecolor_Callback(hObject, eventdata, handles)
% hObject    handle to bluecolor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( gcf, 'Color', [0.5 0.8 0.9] )

% --------------------------------------------------------------------
function greencolor_Callback(hObject, eventdata, handles)
% hObject    handle to greencolor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( gcf, 'Color', [0.1 0.7 0.5] )

% --------------------------------------------------------------------
function orangecolor_Callback(hObject, eventdata, handles)
% hObject    handle to orangecolor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( gcf, 'Color', [0.9 0.5 0] )

% --------------------------------------------------------------------
function pinkcolor_Callback(hObject, eventdata, handles)
% hObject    handle to pinkcolor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set ( gcf, 'Color', [1 0.5 0.6] )

% --------------------------------------------------------------------
function editcolor_Callback(hObject, eventdata, handles)
% hObject    handle to editcolor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
