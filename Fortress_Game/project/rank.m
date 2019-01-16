function varargout = rank(varargin)
% RANK MATLAB code for rank.fig
%      RANK, by itself, creates a new RANK or raises the existing
%      singleton*.
%
%      H = RANK returns the handle to a new RANK or the handle to
%      the existing singleton*.
%
%      RANK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RANK.M with the given input arguments.
%
%      RANK('Property','Value',...) creates a new RANK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rank_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rank_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rank

% Last Modified by GUIDE v2.5 21-Dec-2017 02:43:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rank_OpeningFcn, ...
                   'gui_OutputFcn',  @rank_OutputFcn, ...
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


% --- Executes just before rank is made visible.
function rank_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rank (see VARARGIN)

% Choose default command line output for rank
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rank wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Output all database values 
mat =[]; 
fid=fopen('playerinfo.mat','r');
if(fid>0)
  fclose(fid);
  load playerinfo.mat
  for k=1:length(player)
      mat = [mat ;{player(k).name} player(k).win  player(k).lose player(k).score ];
  end
  mat= sortrows(mat,4,'descend');
else
   h=msgbox('Player is empty','Info');
   uiwait(h); 
end

set(handles.rank_table,'data',mat)

% --- Outputs from this function are returned to the command line.
function varargout = rank_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close


% --- Executes during object creation, after setting all properties.
function rank_table_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rank_table (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
