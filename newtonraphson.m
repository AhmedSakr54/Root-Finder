function varargout = newtonraphson(varargin)
% NEWTONRAPHSON MATLAB code for newtonraphson.fig
%      NEWTONRAPHSON, by itself, creates a new NEWTONRAPHSON or raises the existing
%      singleton*.
%
%      H = NEWTONRAPHSON returns the handle to a new NEWTONRAPHSON or the handle to
%      the existing singleton*.
%
%      NEWTONRAPHSON('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEWTONRAPHSON.M with the given input arguments.
%
%      NEWTONRAPHSON('Property','Value',...) creates a new NEWTONRAPHSON or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before newtonraphson_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to newtonraphson_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help newtonraphson

% Last Modified by GUIDE v2.5 21-Dec-2020 19:41:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @newtonraphson_OpeningFcn, ...
                   'gui_OutputFcn',  @newtonraphson_OutputFcn, ...
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


% --- Executes just before newtonraphson is made visible.
function newtonraphson_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to newtonraphson (see VARARGIN)

% Choose default command line output for newtonraphson
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes newtonraphson wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = newtonraphson_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function expression_Callback(hObject, eventdata, handles)
% hObject    handle to expression (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of expression as text
%        str2double(get(hObject,'String')) returns contents of expression as a double


% --- Executes during object creation, after setting all properties.
function expression_CreateFcn(hObject, eventdata, handles)
% hObject    handle to expression (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x0_Callback(hObject, eventdata, handles)
% hObject    handle to x0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x0 as text
%        str2double(get(hObject,'String')) returns contents of x0 as a double


% --- Executes during object creation, after setting all properties.
function x0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function eps_Callback(hObject, eventdata, handles)
% hObject    handle to eps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eps as text
%        str2double(get(hObject,'String')) returns contents of eps as a double


% --- Executes during object creation, after setting all properties.
function eps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in solve.
function solve_Callback(hObject, eventdata, handles)

if (handles.file.Value == 1)
    if get(handles.filename, 'string') == "" || exist(get(handles.filename, 'string'), 'file') ~= 2
        set(handles.result, 'string', "enter a correct file name");
        errorHandle(handles);
        return;
    end
    fid = fopen(get(handles.filename, 'string'));
    txt = textscan(fid, "%s", 'delimiter', '\n');
    set(handles.expression, 'string', txt{1}{1});
    set(handles.x0, 'string', txt{1}{2});
    set(handles.eps, 'string', txt{1}{3});
    set(handles.max_iter, 'string', txt{1}{4});
    fclose(fid);
end
handles.iterations.ForegroundColor = "black";
x0String = get(handles.x0, 'string');
x0 = -1;
if get(handles.expression, 'string') == ""
    set(handles.result, 'string', "Please enter expression f(x)");
    errorHandle(handles);
    return;  
end
if x0String == ""
    set(handles.result, 'string', "Please enter an initial guess x0!");
    errorHandle(handles);
    return;  
else
x0 = str2double(x0String);

es_symbol = evalin(symengine, get(handles.eps, 'string'));
if get(handles.eps, 'string') == ""
    eps = 0.00001;
else
    eps = vpa(subs(es_symbol));
end
max_iter = -1;
if get(handles.max_iter, 'string') == ""
    max_iter = 50;
else
    max_iter = str2double(get(handles.max_iter, 'string'));
end
if ((get(handles.expression, 'string')) ~= "")
syms x
fx = evalin(symengine, get(handles.expression, 'string'));
dfx = diff(fx);
x_old = x0;
show_iterations = sprintf("x0 = %f\n", x0);
iter_count = 0;
tic
for i=1:1:max_iter
    iter_count = iter_count + 1;
    x = x_old;
    fx_old = vpa(subs(fx));
    dfx_old = vpa(subs(dfx));
    x_new = x_old - (fx_old / dfx_old);
    show_iterations = strcat(show_iterations, sprintf("x%d = %f\n", i, x_new));
    ea = abs((x_new - x_old) / x_new);
    if (ea < eps)
        break;
    end
    x_old = x_new;
end
root = x_new;
time = toc;
set(handles.iterations, 'string', show_iterations);
set(handles.result, 'string', sprintf("the root = %f", root));
set(handles.timeTaken, 'string', sprintf("Execution time = %f", time));
set(handles.numiter, 'string', sprintf("Number of iterations = %d", iter_count));
set(handles.percision, 'string', sprintf("Percision = %f", ea));
else
    set(handles.result, 'string', "Enter an expression");
end
end

function max_iter_Callback(hObject, eventdata, handles)
% hObject    handle to max_iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_iter as text
%        str2double(get(hObject,'String')) returns contents of max_iter as a double


% --- Executes during object creation, after setting all properties.
function max_iter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
menu;
close(newtonraphson);

% --- Executes on button press in file.
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.writeExp.Value == 1
    handles.writeExp.Value = 0;
    switchExpression(handles, "off");
    handles.filename.Enable = "on";
    errorHandle(handles);
    set(handles.result, 'string', "");
end
warning = sprintf("THIS IS IMPORTANT!!!!\nYou have to make sure that the file name has the extension .txt\nIn the file the\n    The first line is the Expression f(x)\n    The second line is x0\n    The Third line is eps\n    The fourth line is max_iter");
set(handles.iterations, 'string', warning);
handles.iterations.ForegroundColor = "red";
% Hint: get(hObject,'Value') returns toggle state of file



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


% --- Executes on button press in writeExp.
function writeExp_Callback(hObject, eventdata, handles)
% hObject    handle to writeExp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.file.Value == 1
    handles.file.Value = 0;
    handles.filename.Enable = "off";
    switchExpression(handles, "on");
    set(handles.iterations, 'string', "");
    errorHandle(handles);
    set(handles.result, 'string', "");
end
% Hint: get(hObject,'Value') returns toggle state of writeExp



function errorHandle(handles)
set(handles.iterations, 'string', "");
set(handles.timeTaken, 'string', "");
set(handles.numiter, 'string', "");
set(handles.percision, 'string', "");

function switchExpression(handles, way)
handles.expression.Enable = way;
handles.x0.Enable = way;
handles.eps.Enable = way;
handles.max_iter.Enable = way;
