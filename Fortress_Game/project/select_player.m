function varargout = select_player(varargin)
% SELECT_PLAYER MATLAB code for select_player.fig
%      SELECT_PLAYER, by itself, creates a new SELECT_PLAYER or raises the existing
%      singleton*.
%
%      H = SELECT_PLAYER returns the handle to a new SELECT_PLAYER or the handle to
%      the existing singleton*.
%
%      SELECT_PLAYER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SELECT_PLAYER.M with the given input arguments.
%
%      SELECT_PLAYER('Property','Value',...) creates a new SELECT_PLAYER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before select_player_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to select_player_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help select_player

% Last Modified by GUIDE v2.5 09-Dec-2017 21:30:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @select_player_OpeningFcn, ...
                   'gui_OutputFcn',  @select_player_OutputFcn, ...
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


% --- Executes just before select_player is made visible.
function select_player_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to select_player (see VARARGIN)

% Choose default command line output for select_player
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% initialize list1 
vec= []; 
fid=fopen('playerinfo.mat','r');
if(fid>0)
  fclose(fid);
  load playerinfo.mat
  for k=1:length(player)
      vec =[vec string(player(k).name)];
  end  
end

set(handles.listbox1,'String',vec);

% Initial UI settings (enable / disable)
initsetvalue(handles);

% When the number of players is less than 2, the UI deactivation process
if length(vec)<2
    all_ui = [handles.player1_select,handles.player2_select,handles.cancel,handles.start];
    set(all_ui,'Enable','off');
end

% Initial UI settings (enable / disable) 
 function initsetvalue(handles)
  
    global select_player
    select_player = [];
    
    set(handles.player1_select,'Enable','on');
    set(handles.listbox1,'Enable','on');
    
    set(handles.player2_select,'Enable','on');
    set(handles.listbox2,'Enable','off');
    set(handles.listbox2,'String','');

% --- Outputs from this function are returned to the command line.
function varargout = select_player_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% Callback function when player 1 select button is pressed
% --- Executes on button press in player1_select.
function player1_select_Callback(hObject, eventdata, handles)
% hObject    handle to player1_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global select_player

player1_index_selected = get(handles.listbox1,'Value');
list = get(handles.listbox1,'String');
[r,c]=size(list);

if r>0
    item_selected = list{player1_index_selected};

    select_player = [select_player {item_selected}];

    % Disable if Player 1 is selected
    set(handles.listbox1,'Enable','off');
    set(handles.player1_select,'Enable','off');

    % Activate Player 2
    set(handles.listbox2,'Enable','on');

    % list-up except player1 selected 
    vec= []; 
    fid=fopen('playerinfo.mat','r');
    if(fid>0)
        fclose(fid);
        load playerinfo.mat
        for k=1:length(player)
            if(k~=player1_index_selected)
            vec =[vec string(player(k).name)];
            end
        end 
    end

    set(handles.listbox2,'String',vec);
end

% --- Executes on button press in player2_select.
function player2_select_Callback(hObject, eventdata, handles)
% hObject    handle to player2_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global select_player

player2_index_selected = get(handles.listbox2,'Value');
list2 = get(handles.listbox2,'String');
[r,c]=size(list2);

if r>0
    if r>1
    item_selected = list2{player2_index_selected};
    else
    item_selected = list2;
    end

    select_player = [select_player {item_selected}];
    
    % Disable when action is taken
    set(hObject,'Enable','off');
    set(handles.listbox2,'Enable','off');
end

% --- Executes on button press in cancel.
function cancel_Callback(hObject, eventdata, handles)
% hObject    handle to cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
initsetvalue(handles)

% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global select_player

% Handling Passing Values to Another GUI
handles.passdata = select_player;
guidata(hObject,handles);

% Close current window
close

% execute
execute_game(handles);

% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
