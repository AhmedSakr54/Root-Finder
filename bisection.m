function varargout = bisection(varargin)
% BISECTION MATLAB code for bisection.fig
%      BISECTION, by itself, creates a new BISECTION or raises the existing
%      singleton*.
%
%      H = BISECTION returns the handle to a new BISECTION or the handle to
%      the existing singleton*.
%
%      BISECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BISECTION.M with the given input arguments.
%
%      BISECTION('Property','Value',...) creates a new BISECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bisection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bisection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bisection

% Last Modified by GUIDE v2.5 21-Dec-2020 00:54:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bisection_OpeningFcn, ...
                   'gui_OutputFcn',  @bisection_OutputFcn, ...
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


% --- Executes just before bisection is made visible.
function bisection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bisection (see VARARGIN)

% Choose default command line output for bisection
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes bisection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = bisection_OutputFcn(hObject, eventdata, handles) 
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



function xl_Callback(hObject, eventdata, handles)
% hObject    handle to xl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xl as text
%        str2double(get(hObject,'String')) returns contents of xl as a double


% --- Executes during object creation, after setting all properties.
function xl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xu_Callback(hObject, eventdata, handles)
% hObject    handle to xu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xu as text
%        str2double(get(hObject,'String')) returns contents of xu as a double


% --- Executes during object creation, after setting all properties.
function xu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xu (see GCBO)
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
xlString = get(handles.xl, 'string');
xuString = get(handles.xu, 'string');
xl = -1;
xu = -1;
if xlString == ""
    set(handles.result, 'string', "Please enter a value for xl!");
else
    xl = str2double(xlString);
end
if xuString == ""
    set(handles.result, 'string', "Please enter a value for xu!");
else
    xu = str2double(xuString);
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
tic
x = xl;
fxl = vpa(subs(fx));
x = xu;
fxu = vpa(subs(fx));
iter_count = 0;
if (fxl * fxu <= 0)
    xr = xl + xu / 2;
    x = xr;
    fxr = vpa(subs(fx));
    if (fxl*fxr > 0)
        xl = xr;
    else
        xu = xr;
    end
    xr_old = xr;
    show_iterations = sprintf("xr1 = %f\n", xr);
    iter_count = iter_count + 1;
    for i = 2:1:max_iter
       xr = (xl+xu)/2;
       ea = abs((xr-xr_old)/xr);
       x = xl;
       fxl = vpa(subs(fx));
       x = xr;
       fxr = vpa(subs(fx));
       test_val = fxl*fxr;
       if (test_val < 0)
           xu = xr;
       else
           xl = xr;
       end
       if (test_val == 0)
           ea = 0;
       end
       if (ea <= eps) 
           break;
       end
       xr_old = xr;
       show_iterations = strcat(show_iterations, sprintf("xr%d = %f\n", i, xr));
       iter_count = iter_count + 1;
    end
    root = xr;
    time = toc;
%     results_string = sprintf("the root = %f\nExecution time = %f\nNumber of iterations = %d", root, time, iter_count);
    set(handles.iterations, 'string', show_iterations);
    set(handles.result, 'string', sprintf("the root = %f", root));
    set(handles.timeTaken, 'string', sprintf("Execution time = %f", time));
    set(handles.numiter, 'string', sprintf("Number of iterations = %d", iter_count));
    set(handles.percision, 'string', sprintf("Percision = %f", ea));
else
    set(handles.result, 'string', "could not perform bisection method");
    set(handles.iterations, 'string', "");
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
close(bisection);
