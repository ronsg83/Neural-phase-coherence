function varargout = aTestABXn(varargin)
% ATESTABX M-file for aTest.fig
%      ATESTABX, by itself, creates a new ATESTABX or raises the existing
%      singleton*.
%
%      H = ATEST returns the handle to a new ATESTABX or the handle to
%      the existing singleton*.
%
%      ATESTABX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ATEST.M with the given input arguments.
%
%      ATESTABX('Property','Value',...) creates a new ATEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before aTest_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to aTest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%    varargin
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help aTest

% Last Modified by GUIDE v2.5 11-May-2006 00:18:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @aTest_OpeningFcn, ...
                   'gui_OutputFcn',  @aTest_OutputFcn, ...
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


% --- Executes just before aTest is made visible.
function aTest_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to aTestABX (see VARARGIN)

% Choose default command line output for aTestABX
handles.output = hObject;

% Update handles structure
if varargin{1}
    set(handles.pushbutton1,'Enable','off')
    set(handles.pushbutton2,'Enable','off')
    set(handles.pushbutton3,'Enable','on')
else
    set(handles.pushbutton1,'Enable','on')
    set(handles.pushbutton2,'Enable','on')
    set(handles.pushbutton3,'Enable','off')
end
guidata(hObject, handles);

% UIWAIT makes aTestABX wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = aTest_OutputFcn(hObject, eventdata, handles) 
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
handles.output = 'A';
guidata(hObject, handles);
uiresume;

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = 'B';
guidata(hObject, handles);
uiresume;

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = 'Listen';
guidata(hObject, handles);
set(handles.pushbutton3,'Enable','off');
uiresume;


