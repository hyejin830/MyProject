function varargout = view_player(varargin)
% VIEW_PLAYER MATLAB code for view_player.fig
%      VIEW_PLAYER, by itself, creates a new VIEW_PLAYER or raises the existing
%      singleton*.
%
%      H = VIEW_PLAYER returns the handle to a new VIEW_PLAYER or the handle to
%      the existing singleton*.
%
%      VIEW_PLAYER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIEW_PLAYER.M with the given input arguments.
%
%      VIEW_PLAYER('Property','Value',...) creates a new VIEW_PLAYER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before view_player_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to view_player_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help view_player

% Last Modified by GUIDE v2.5 08-Dec-2017 20:37:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @view_player_OpeningFcn, ...
                   'gui_OutputFcn',  @view_player_OutputFcn, ...
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


% --- Executes just before view_player is made visible.
function view_player_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to view_player (see VARARGIN)

% Choose default command line output for view_player
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Show all database values in a table
mat =[]; 
fid=fopen('playerinfo.mat','r');
if(fid>0)
  fclose(fid);
  load playerinfo.mat
  for k=1:length(player)
      mat = [mat ;{player(k).name} player(k).win  player(k).lose player(k).score ];
  end
else
   % Process when there is no data
   h=msgbox('Player is empty','Info');
   uiwait(h); 
end
 
set(handles.view_table,'data',mat);

% --- Outputs from this function are returned to the command line.
function varargout = view_player_OutputFcn(hObject, eventdata, handles) 
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
close
