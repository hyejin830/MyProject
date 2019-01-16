function varargout = execute_game(varargin)
% EXECUTE_GAME MATLAB code for execute_game.fig
%      EXECUTE_GAME, by itself, creates a new EXECUTE_GAME or raises the existing
%      singleton*.
%
%      H = EXECUTE_GAME returns the handle to a new EXECUTE_GAME or the handle to
%      the existing singleton*.
%
%      EXECUTE_GAME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXECUTE_GAME.M with the given input arguments.
%
%      EXECUTE_GAME('Property','Value',...) creates a new EXECUTE_GAME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before execute_game_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to execute_game_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help execute_game

% Last Modified by GUIDE v2.5 21-Dec-2017 15:27:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                    'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @execute_game_OpeningFcn, ...
                   'gui_OutputFcn',  @execute_game_OutputFcn, ...
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

% --- Executes just before execute_game is made visible.
function execute_game_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to execute_game (see VARARGIN)
% Choose default command line output for execute_game
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% Processing data received from select player(Name of two players)
handles.passdata = varargin{1}.passdata;

global player_data hand
global p1_vec p2_vec
global player1 player2

% Store two player names in global variables
player_data = handles.passdata;

% Handle global variable declaration and vectorize each player's UIControls.
hand = handles;
player1 = [handles.px1_up_button, handles.px1_down_button, handles.py1_up_button,handles.py1_down_button,...
        handles.p1_angle_slide,handles.p1_speed_slide,handles.player1_hit,handles.p1_move_chance];
player2 = [handles.px2_up_button, handles.px2_down_button, handles.py2_up_button,handles.py2_down_button,...
        handles.p2_angle_slide,handles.p2_speed_slide,handles.player2_hit,handles.p2_move_chance];

%-----------------------Initialize data-------------------------------------%
% VALUENUM.m reference (constant)
% VALUENUM.X = 1 -> x coordinate, VALUENUM.Y = 2 -> y coordinate, 
% VALUENUM.ANGLE = 3 -> angle, VALUENUM.VELOCITY =4 -> speed, 
% VALUENUM.SCORE = 5 -> score, VALUENUM.MOVE = 6 -> movement opportunity

% Player 1's initial value
p1_vec(VALUENUM.X) = rand*100; 
p1_vec(VALUENUM.Y) = rand*200; 
p1_vec(VALUENUM.ANGLE) = 0; 
p1_vec(VALUENUM.VELOCITY) = 0; 
p1_vec(VALUENUM.SCORE) = 100;
p1_vec(VALUENUM.MOVE) = 5;

%Player 2's initial value
p2_vec(VALUENUM.X) = rand*100+100;
p2_vec(VALUENUM.Y) = rand*200;
p2_vec(VALUENUM.ANGLE) = 0;
p2_vec(VALUENUM.VELOCITY) = 0;
p2_vec(VALUENUM.SCORE) = 100;
p2_vec(VALUENUM.MOVE) = 5;

% Initial UI Enable / Disable Settings
actinact(1,0); % player 1 active player2 disabled

function varargout = execute_game_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
global p1_k_num p2_k_num
global player_data
global p1_vec p2_vec

varargout{1} = handles.output;

% ------------ Output each user's name and item -----------------%
p_info = getinfo(player_data(1));
set(handles.info_player1,'String',"   Name :"+string(player_data(1))+newline...
                                 +"Win:      "+num2str(p_info(1))+newline...
                                 +"Lose:     "+num2str(p_info(2))+newline...
                                 +"Score:    "+num2str(p_info(3)));
% Player 1 database index value
p1_k_num=p_info(4);

p_info = getinfo(player_data(2));                            
set(handles.info_player2,'String',"   Name :"+string(player_data(2))+newline...
                                 +"Win:      "+num2str(p_info(1))+newline...
                                 +"Lose:     "+num2str(p_info(2))+newline...
                                 +"Score:    "+num2str(p_info(3)));
% Player 2 database index value
p2_k_num=p_info(4);

% --------------- Setting & Output graph ------------------ %

% Player 1 Graph Settings
plot(handles.window,p1_vec(VALUENUM.X),p1_vec(VALUENUM.Y),'pr','markersize',20,'markerfacecolor','r');
% Show Player 1 Coordinates 
set(handles.player1_x,'String','X : '+string(num2str(p1_vec(VALUENUM.X))));
set(handles.player1_y,'String','Y : '+string(num2str(p1_vec(VALUENUM.Y))));
hold on;

% Player 2 Graph Settings
plot(handles.window,p2_vec(VALUENUM.X),p2_vec(VALUENUM.Y),'pb','markersize',20,'markerfacecolor','b');
% Show Player 2 Coordinates 
set(handles.player2_x,'String','X : '+string(num2str(p2_vec(VALUENUM.X))));
set(handles.player2_y,'String','Y : '+string(num2str(p2_vec(VALUENUM.Y))));
hold on;

% --------------- Energy & Move ------------------ %

% Energy setting
set(handles.p1_energy,'String',num2str(p1_vec(VALUENUM.SCORE)));
set(handles.p2_energy,'String',num2str(p2_vec(VALUENUM.SCORE)));

% Motion settings
set(handles.p1_move_chance,'String',num2str(p1_vec(VALUENUM.MOVE)));
set(handles.p2_move_chance,'String',num2str(p2_vec(VALUENUM.MOVE)));


 % Get win, lose, score according to player name 
function p_info = getinfo(data)
fid=fopen('playerinfo.mat','r');
if(fid>0)
  fclose(fid);
  load playerinfo.mat
  for k=1:length(player)
      if strcmp(string(data),player(k).name)
        p_info = [ player(k).win player(k).lose player(k).score k ];      
      end      
  end
end

% --- Executes during object creation, after setting all properties.
function window_CreateFcn(hObject, eventdata, handles)
% hObject    handle to window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Graph initialization
set(hObject,'XLim',[0 200]);
set(hObject,'YLim',[0 200]);
matlabImage = imread('sam33.png');
image(matlabImage);
axis on;
hold on;

 
% --- Executes on button press in player1_hit.
function player1_hit_Callback(hObject, eventdata, handles)
% hObject    handle to player1_hit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global p1_vec p2_vec

% setting inital value and runtime
rotationVector = linspace(360, 0, 250) * pi/180;
square = [[0 5 5 0 0];[0 0 5 5 0]];
didCollide = 0;
t = linspace (0,8,250);

% while-end animation processing
i = 1;
while i < length(t)             
    
  if i~=1
     delete(h1);      % Program conflict handling
  end

  set(handles.window,'XLim',[0 200]);
  set(handles.window,'YLim',[0 200]);
  hold on;
    
  rotationMatrix = [cos(rotationVector(i)) -sin(rotationVector(i))        %Calculate values to be used for rotation
                    sin(rotationVector(i)) cos(rotationVector(i))];

  % set x,y value
  x = (p1_vec(VALUENUM.VELOCITY)*t(i))*cosd(p1_vec(VALUENUM.ANGLE))+p1_vec(VALUENUM.X);                                     %Calculate horizontal position
  y = (0 + (p1_vec(VALUENUM.VELOCITY) * t(i))*sind(p1_vec(VALUENUM.ANGLE)) - (9.8 * power(t(i), 2))/2)+p1_vec(VALUENUM.Y); %Calculate vertical position

  % Keep checking to see if the bomb hit.
  hit = Collision(x, y, p2_vec(VALUENUM.X), p2_vec(VALUENUM.Y));      
  
  % Keep checking to see if the bomb hit.
  if (hit == 1)           
     i = length(t);      
     didCollide=1;
  end

  %Apply the rotation to bomb shape & draw
  rotatedSquare = [[square(1,:)];[square(2,:)]];  
  rotatedSquare = rotationMatrix *rotatedSquare;
  h1 = fill(rotatedSquare(1,:) + x, rotatedSquare(2,:) + y, 'r','Parent',handles.window); 
  
  %Pause to simulate animation
  pause(0.01);       
  i = i + 1;
  
end
    
% Maximum height calculation
set(handles.max_height,'String',num2str(calc_height(p1_vec(VALUENUM.VELOCITY),p1_vec(VALUENUM.ANGLE))+p1_vec(VALUENUM.Y)));

if didCollide ==1
   delete(h1)
   if p2_vec(VALUENUM.SCORE)  ==10
      game_end(1); % If player1 wins
   else
      p2_vec(VALUENUM.SCORE) = p2_vec(VALUENUM.SCORE)-10;
      h=msgbox('GOOD JOB!','INFO');
      set(handles.p2_energy,'String',num2str(p2_vec(VALUENUM.SCORE)));    
      pause(3);
      actinact(2,1); % player 2 active player1 disabled
   end  
else
   actinact(2,1); % player 2 active player1 disabled
end
    
% --- Executes on button press in player2_hit.
function player2_hit_Callback(hObject, eventdata, handles)
% hObject    handle to player2_hit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global p1_vec p2_vec

% setting inital value and runtime
rotationVector = linspace(360, 0, 250) * pi/180;
bomb = [[0 5 5 0 0];[0 0 5 5 0]];
IsCollide=0;
t = linspace (0,8, 250); 

% while-end animation processing
i = 1;
while i < length(t)             
    if i~=1
        delete(h1)      % Program conflict handling
    end

    set(handles.window,'XLim',[0 200]);
    set(handles.window,'YLim',[0 200]);
    hold on;
    
    rotationMatrix = [cos(rotationVector(i)) -sin(rotationVector(i))        %Calculate values to be used for rotation
                      sin(rotationVector(i)) cos(rotationVector(i))];
    
    % set x,y value
    x = -((p2_vec(VALUENUM.VELOCITY)*t(i))*cosd(p2_vec(VALUENUM.ANGLE)))+p2_vec(VALUENUM.X);      %Clate horizontal position
    y = (0 + (p2_vec(VALUENUM.VELOCITY) * t(i))*sind(p2_vec(VALUENUM.ANGLE)) - (9.8 * power(t(i), 2))/2)+p2_vec(VALUENUM.Y);  %Calculate vertical position
    
    % Keep checking to see if the bomb hit.
    hit = Collision(x, y, p1_vec(VALUENUM.X), p1_vec(VALUENUM.Y));      
    
    % Handles the case where the bomb is hit by the opponent
    if (hit == 1)           
        i = length(t);      
        IsCollide=1;
    end

    %Apply the rotation to bomb shape & draw
    rotatedSquare = [[bomb(1,:)];[bomb(2,:)]];  
    rotatedSquare = rotationMatrix *rotatedSquare;
    h1 = fill(rotatedSquare(1,:) + x, rotatedSquare(2,:) + y, 'b','Parent',handles.window);

    %Pause to simulate animation
    pause(0.01);        
    i = i + 1;
end 

% Maximum height calculation
set(handles.max_height,'String',num2str(calc_height(p2_vec(VALUENUM.VELOCITY),p2_vec(VALUENUM.ANGLE))+p2_vec(VALUENUM.Y)));

% Energy after collision and GUI processing
if IsCollide ==1
    delete(h1);
    if p1_vec(VALUENUM.SCORE) ==10 
        game_end(2); %If player2 wins
    else
        p1_vec(VALUENUM.SCORE) = p1_vec(VALUENUM.SCORE)-10;
        h=msgbox('GOOD JOB!','INFO');
        set(handles.p1_energy,'String',num2str(p1_vec(VALUENUM.SCORE))) ;
        pause(3)
        actinact(1,1); % player 1 active player2 disabled
    end
else 
    actinact(1,1); % player 1 active player2 disabled
end
  
% Turning Player UI On / Off
function actinact(pNum,state)
    global player1 player2
    global p1_vec p2_vec
    
    if pNum ==1 % player 1 active player2 disabled
        set(player1,'Enable','on');
        set(player2,'Enable','off');
        set(player1(8),'String',num2str(p1_vec(VALUENUM.MOVE)));
        p2_vec(VALUENUM.MOVE)=5;
        if state == 1 % During game
            h=msgbox('PLAYER1 TURN','INFO');
        end
    elseif pNum ==2 % player 2 active player1 disabled
        set(player2,'Enable','on');
        set(player1,'Enable','off');
        set(player2(8),'String',num2str(p2_vec(VALUENUM.MOVE)));
        p1_vec(VALUENUM.MOVE) = 5;
        h=msgbox('PLAYER2 TURN','INFO');
    end

% Refresh graph when moving coordinates    
function refresh(play_num)
global hand p1_vec p2_vec

cla(hand.window);
matlabImage = imread('sam33.png');
image(matlabImage);
plot(hand.window,p1_vec(VALUENUM.X),p1_vec(VALUENUM.Y),'pr','markersize',20,'markerfacecolor','r');
plot(hand.window,p2_vec(VALUENUM.X),p2_vec(VALUENUM.Y),'pb','markersize',20,'markerfacecolor','b');

hold on;

player_x=0;
player_y=0;

if play_num == 1
    player_x = p1_vec(VALUENUM.X);
    player_y = p1_vec(VALUENUM.Y);
    set(hand.player1_x,'String','X : '+string(num2str(player_x)));
    set(hand.player1_y,'String','Y : '+string(num2str(player_y)));
elseif play_num == 2
    player_x = p2_vec(VALUENUM.X);
    player_y = p2_vec(VALUENUM.Y);
    set(hand.player2_x,'String','X : '+string(num2str(player_x)));
    set(hand.player2_y,'String','Y : '+string(num2str(player_y)));
end

% Actions when the number of coordinate moves exceeds 
function axis_button_refresh(p_num)
    global player1 player2
    if p_num==1 % Player 1
       set(player1(1:4),'Enable','off');
    elseif p_num==2 %Player 2
       set(player2(1:4),'Enable','off');
    end

%------------------- Move Coordinate Callback Function -------------------%

% Player1 case

% --- Executes on button press in px1_up_button.
function px1_up_button_Callback(hObject, eventdata, handles)
% hObject    handle to px1_up_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global p1_vec

if p1_vec(VALUENUM.X)+5>100
    h=msgbox('It should not exceed 100 ~!','Error');
else 
    p1_vec(VALUENUM.MOVE) = p1_vec(VALUENUM.MOVE)-1;
    set(handles.p1_move_chance,'String',num2str(p1_vec(VALUENUM.MOVE)));
    p1_vec(VALUENUM.X)=p1_vec(VALUENUM.X)+5;
    refresh(1);
end

% If p1_move is 0, all (coordinate shift button) disable code
if p1_vec(VALUENUM.MOVE) ==0
    axis_button_refresh(1);
end   
% --- Executes on button press in px1_down_button.
function px1_down_button_Callback(hObject, eventdata, handles)
% hObject    handle to px1_down_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global p1_vec

if p1_vec(VALUENUM.X)-5<0
    h=msgbox('It should not be less than 0 ~!','Error');
else 
    p1_vec(VALUENUM.MOVE) = p1_vec(VALUENUM.MOVE)-1;
    set(handles.p1_move_chance,'String',num2str(p1_vec(VALUENUM.MOVE)));
    p1_vec(VALUENUM.X)=p1_vec(VALUENUM.X)-5;
    refresh(1);
end

% If p1_move is 0, all (coordinate shift button) disable code
if p1_vec(VALUENUM.MOVE) ==0
    axis_button_refresh(1);
end   
% --- Executes on button press in py1_up_button.
function py1_up_button_Callback(hObject, eventdata, handles)
% hObject    handle to py1_up_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global p1_vec 

if p1_vec(VALUENUM.Y)+5>200
    h=msgbox('It should not exceed 200 ~!','Error');
else 
     p1_vec(VALUENUM.MOVE) = p1_vec(VALUENUM.MOVE)-1;
    set(handles.p1_move_chance,'String',num2str(p1_vec(VALUENUM.MOVE)));
    p1_vec(VALUENUM.Y) = p1_vec(VALUENUM.Y)+5;
    refresh(1);
end

% If p1_move is 0, all (coordinate shift button) disable code 
if p1_vec(VALUENUM.MOVE) ==0
    axis_button_refresh(1);
end   
% --- Executes on button press in py1_down_button.
function py1_down_button_Callback(hObject, eventdata, handles)
% hObject    handle to py1_down_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global p1_vec

if  p1_vec(VALUENUM.Y)-5<0
    h=msgbox('It should not be less than 0 ~!','Error');
else 
    p1_vec(VALUENUM.MOVE) = p1_vec(VALUENUM.MOVE)-1;
    set(handles.p1_move_chance,'String',num2str(p1_vec(VALUENUM.MOVE)));
    p1_vec(VALUENUM.Y) = p1_vec(VALUENUM.Y)-5;
    refresh(1)
end

% If p1_move is 0, all (coordinate shift button) disable code 
if p1_vec(VALUENUM.MOVE) ==0
    axis_button_refresh(1);
end   

% Player2 case

% --- Executes on button press in px2_up_button.
function px2_up_button_Callback(hObject, eventdata, handles)
% hObject    handle to px2_up_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global p2_vec

if  p2_vec(VALUENUM.X)+5>200
    
    h=msgbox('It should not exceed 200 ~!','Error');
else 
    p2_vec(VALUENUM.MOVE) = p2_vec(VALUENUM.MOVE)-1;
    set(handles.p2_move_chance,'String',num2str(p2_vec(VALUENUM.MOVE)));
    p2_vec(VALUENUM.X) = p2_vec(VALUENUM.X)+5;
    refresh(2);
end

% If p2_move is 0, all (coordinate shift button) disable code 
if p2_vec(VALUENUM.MOVE) ==0
    axis_button_refresh(2);
end   
% --- Executes on button press in px2_down_button.
function px2_down_button_Callback(hObject, eventdata, handles)
% hObject    handle to px2_down_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global p2_vec

if  p2_vec(VALUENUM.X)-5<100
    
    h=msgbox('It should not be less than 100 ~!','Error');
else 
    p2_vec(VALUENUM.MOVE) = p2_vec(VALUENUM.MOVE)-1;
    set(handles.p2_move_chance,'String',num2str(p2_vec(VALUENUM.MOVE)));
    p2_vec(VALUENUM.X) = p2_vec(VALUENUM.X)-5;
    refresh(2);
end

% If p2_move is 0, all (coordinate shift button) disable code
if p2_vec(VALUENUM.MOVE) ==0
    axis_button_refresh(2);
end   
% --- Executes on button press in py2_up_button.
function py2_up_button_Callback(hObject, eventdata, handles)
% hObject    handle to py2_up_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global p2_vec

if  p2_vec(VALUENUM.Y)+5>200
    
    h=msgbox('It should not exceed 200 ~!','Error');
else 
    p2_vec(VALUENUM.MOVE) = p2_vec(VALUENUM.MOVE)-1;
    set(handles.p2_move_chance,'String',num2str(p2_vec(VALUENUM.MOVE)));
    p2_vec(VALUENUM.Y) = p2_vec(VALUENUM.Y)+5;
    refresh(2);
end

% If p2_move is 0, all (coordinate shift button) disable code
if p2_vec(VALUENUM.MOVE) ==0
    axis_button_refresh(2);
end  
% --- Executes on button press in py2_down_button.
function py2_down_button_Callback(hObject, eventdata, handles)
% hObject    handle to py2_down_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global p2_vec

if  p2_vec(VALUENUM.Y)-5<0
   
    h=msgbox('It should not be less than 0 ~!','Error');
else 
    p2_vec(VALUENUM.MOVE) = p2_vec(VALUENUM.MOVE)-1;
    set(handles.p2_move_chance,'String',num2str(p2_vec(VALUENUM.MOVE)));
    p2_vec(VALUENUM.Y) = p2_vec(VALUENUM.Y)-5;
    refresh(2);
end

% If p2_move is 0, all (coordinate shift button) disable code
if p2_vec(VALUENUM.MOVE) ==0
    axis_button_refresh(2);
end  

%------------------- Angle and Velocity Callback Functions -------------------%

% Player1 case

% --- Executes on slider movement.
function p1_angle_slide_Callback(hObject, eventdata, handles)
% hObject    handle to p1_angle_slide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global p1_vec

value = get(hObject,'value');
p1_vec(VALUENUM.ANGLE) = fix(value);
set(handles.p1_angle_value,'String',num2str(fix(value)));

% --- Executes on slider movement.
function p1_speed_slide_Callback(hObject, eventdata, handles)
% hObject    handle to p1_speed_slide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global p1_vec

value = get(hObject,'value');
p1_vec(VALUENUM.VELOCITY) = fix(value);
set(handles.p1_speed_value,'String',num2str(fix(value)));

% Player2 case

% --- Executes on slider movement.
function p2_angle_slide_Callback(hObject, eventdata, handles)
% hObject    handle to p2_angle_slide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global p2_vec

value = get(hObject,'value');
p2_vec(VALUENUM.ANGLE) = fix(value);
set(handles.p2_angle_value,'String',num2str(fix(value)));

% --- Executes on slider movement.
function p2_speed_slide_Callback(hObject, eventdata, handles)
% hObject    handle to p2_speed_slide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global p2_vec

value = get(hObject,'value');
p2_vec(VALUENUM.VELOCITY) = fix(value);
set(handles.p2_speed_value,'String',num2str(fix(value)));

% Processing at the end of game
 function game_end(index)
     global p1_k_num p2_k_num
     global p1_vec p2_vec
     
     h=msgbox('GAME OVER','h');
     fid=fopen('playerinfo.mat','r');
     if(fid>0)
        fclose(fid);
        load playerinfo.mat
        if index==1 %% If player1 wins
           player(p1_k_num).win = player(p1_k_num).win+1; 
           player(p2_k_num).lose = player(p2_k_num).lose+1; 
           player(p1_k_num).score = player(p1_k_num).score+p1_vec(VALUENUM.SCORE);  
        elseif index==2 %% If player2 wins
           player(p2_k_num).win = player(p2_k_num).win+1; 
           player(p1_k_num).lose = player(p1_k_num).lose+1; 
           player(p2_k_num).score = player(p2_k_num).score+p2_vec(VALUENUM.SCORE); 
        end
        save playerinfo player
     end
      
     pause(5) % Go to main after closing game window
     close all
     Main

% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
