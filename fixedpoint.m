function varargout = fixedpoint(varargin)
% FIXEDPOINT MATLAB code for fixedpoint.fig
%      FIXEDPOINT, by itself, creates a new FIXEDPOINT or raises the existing
%      singleton*.
%
%      H = FIXEDPOINT returns the handle to a new FIXEDPOINT or the handle to
%      the existing singleton*.
%
%      FIXEDPOINT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIXEDPOINT.M with the given input arguments.
%
%      FIXEDPOINT('Property','Value',...) creates a new FIXEDPOINT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fixedpoint_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fixedpoint_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fixedpoint

% Last Modified by GUIDE v2.5 21-Dec-2020 17:49:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fixedpoint_OpeningFcn, ...
                   'gui_OutputFcn',  @fixedpoint_OutputFcn, ...
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


% --- Executes just before fixedpoint is made visible.
function fixedpoint_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fixedpoint (see VARARGIN)

% Choose default command line output for fixedpoint
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fixedpoint wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fixedpoint_OutputFcn(hObject, eventdata, handles) 
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
if get(handles.expression, 'string') == ""
    set(handles.result, 'string', "Please enter expression f(x)");
    errorHandle(handles);
    return;  
end
if get(handles.gx, 'string') == ""
    set(handles.result, 'string', "Please enter a g(x) expression");
    errorHandle(handles);
    return;
end
if get(handles.x0, 'string') == ""
    set(handles.result, 'string', "Please enter x0");
    errorHandle(handles);
    return;
end
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
syms x
fx = evalin(symengine, get(handles.expression, 'string'));
gx = evalin(symengine, get(handles.gx, 'string'));
x0 = str2double(get(handles.x0, 'string'));
show_iterations = sprintf("x0 = %f\n", x0);
iter_count = 0;
tic
dgx = diff(gx);
x = x0;
dgx_val = vpa(subs(dgx));
if abs(dgx_val) >=   1
    set(handles.result, 'string', "Iterations will Diverge");
    errorHandle(handles);
    return;
end
for i = 1:1:max_iter
    x = x0;
    x_new = vpa(subs(gx));
    show_iterations = strcat(show_iterations, sprintf("x%d = %f\n", i, x_new));
    ea = abs((x_new - x0) / x_new);
    iter_count = iter_count + 1;
    if ea < eps
        break;
    end
    x0 = x_new;
end
root = x_new;
time = toc;
set(handles.iterations, 'string', show_iterations);
set(handles.result, 'string', sprintf("the root = %f", root));
set(handles.timeTaken, 'string', sprintf("Execution time = %f", time));
set(handles.numiter, 'string', sprintf("Number of iterations = %d", iter_count));
set(handles.percision, 'string', sprintf("Percision = %f", ea));



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
close(fixedpoint);



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



function gx_Callback(hObject, eventdata, handles)
% hObject    handle to gx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gx as text
%        str2double(get(hObject,'String')) returns contents of gx as a double


% --- Executes during object creation, after setting all properties.
function gx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function errorHandle(handles)
set(handles.iterations, 'string', "");
set(handles.timeTaken, 'string', "");
set(handles.numiter, 'string', "");
set(handles.percision, 'string', "");
