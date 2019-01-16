function varargout = save_player(varargin)
% SAVE_PLAYER MATLAB code for save_player.fig
%      SAVE_PLAYER, by itself, creates a new SAVE_PLAYER or raises the existing
%      singleton*.
%
%      H = SAVE_PLAYER returns the handle to a new SAVE_PLAYER or the handle to
%      the existing singleton*.
%
%      SAVE_PLAYER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAVE_PLAYER.M with the given input arguments.
%
%      SAVE_PLAYER('Property','Value',...) creates a new SAVE_PLAYER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before save_player_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to save_player_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help save_player

% Last Modified by GUIDE v2.5 08-Dec-2017 18:45:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @save_player_OpeningFcn, ...
                   'gui_OutputFcn',  @save_player_OutputFcn, ...
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


% --- Executes just before save_player is made visible.
function save_player_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to save_player (see VARARGIN)

% Choose default command line output for save_player
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% edittext intialize 
set(handles.new_name,'String','');

% UIWAIT makes save_player wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = save_player_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function new_name_Callback(hObject, eventdata, handles)
% hObject    handle to new_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of new_name as text
%        str2double(get(hObject,'String')) returns contents of new_name as a double


% --- Executes during object creation, after setting all properties.
function new_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to new_name (see GCBO)
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

% Get the name from edittext and initialize it to mat file
input_name = get(handles.new_name,'String');
 
fid = fopen('playerinfo.mat','r')
if(fid>0)
       fclose(fid);
       load playerinfo.mat
       k=length(player)+1
    else
        k=1;
 end
if compare_name(input_name)==1
    h=msgbox('It has the same name. Please use a different name','Error');
    set(handles.new_name,'String','');
else
    player(k).name=input_name;        
    player(k).win=0;
    player(k).lose=0;
    player(k).score=0;
    h=msgbox('Your name is stored.','Success');
    set(handles.new_name,'String','');
end
save playerinfo player 

    
 
% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
