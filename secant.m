function varargout = secant(varargin)
% SECANT MATLAB code for secant.fig
%      SECANT, by itself, creates a new SECANT or raises the existing
%      singleton*.
%
%      H = SECANT returns the handle to a new SECANT or the handle to
%      the existing singleton*.
%
%      SECANT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SECANT.M with the given input arguments.
%
%      SECANT('Property','Value',...) creates a new SECANT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before secant_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to secant_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help secant

% Last Modified by GUIDE v2.5 21-Dec-2020 17:17:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @secant_OpeningFcn, ...
                   'gui_OutputFcn',  @secant_OutputFcn, ...
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


% --- Executes just before secant is made visible.
function secant_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to secant (see VARARGIN)

% Choose default command line output for secant
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes secant wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = secant_OutputFcn(hObject, eventdata, handles) 
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



function x2nd_Callback(hObject, eventdata, handles)
% hObject    handle to x2nd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x2nd as text
%        str2double(get(hObject,'String')) returns contents of x2nd as a double


% --- Executes during object creation, after setting all properties.
function x2nd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x2nd (see GCBO)
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
x0String = get(handles.x2nd, 'string');
xSub1String = get(handles.x1st, 'string');
x0 = -1;
xSub1 = -1;
if x0String == ""
    set(handles.result, 'string', "Please enter a second guess!");
    set(handles.iterations, 'string', "");
    set(handles.result, 'string', "");
    set(handles.timeTaken, 'string', "");
    set(handles.numiter, 'string', "");
    set(handles.percision, 'string', "");
else
    x0 = str2double(x0String);
end
if xSub1String == ""
    set(handles.result, 'string', "Please enter a first guess!");
    set(handles.iterations, 'string', "");
    set(handles.result, 'string', "");
    set(handles.timeTaken, 'string', "");
    set(handles.numiter, 'string', "");
    set(handles.percision, 'string', "");
else
    xSub1 = str2double(xSub1String);
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
show_iterations = sprintf("x0 = %f\n", x0);
iter_count = 0;
tic
for i=1:1:max_iter
    x = xSub1;
    fx_minus1 = vpa(subs(fx));
    x = x0;
    fx0 = vpa(subs(fx));
    x_new = x0 - ((fx0*(x0-xSub1))/(fx0-fx_minus1));
    ea = abs((x_new - x0) / x_new);
    show_iterations = strcat(show_iterations, sprintf("x%d = %f\n", i, x_new));
    iter_count = iter_count + 1;
    if (ea < eps)
        break;
    end
    x = x_new;
    fx_new = vpa(subs(fx));
    fx_minus1 = fx0;
    fx0 = fx_new;
    xSub1 = x0;
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
close(secant);



function x1st_Callback(hObject, eventdata, handles)
% hObject    handle to x1st (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x1st as text
%        str2double(get(hObject,'String')) returns contents of x1st as a double


% --- Executes during object creation, after setting all properties.
function x1st_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x1st (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
