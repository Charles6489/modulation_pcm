function varargout = pcm_audio(varargin)
% PCM_AUDIO MATLAB code for pcm_audio.fig
%      PCM_AUDIO, by itself, creates a new PCM_AUDIO or raises the existing
%      singleton*.
%
%      H = PCM_AUDIO returns the handle to a new PCM_AUDIO or the handle to
%      the existing singleton*.
%
%      PCM_AUDIO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PCM_AUDIO.M with the given input arguments.
%
%      PCM_AUDIO('Property','Value',...) creates a new PCM_AUDIO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pcm_audio_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pcm_audio_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pcm_audio

% Last Modified by GUIDE v2.5 16-Apr-2021 19:15:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pcm_audio_OpeningFcn, ...
                   'gui_OutputFcn',  @pcm_audio_OutputFcn, ...
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


% --- Executes just before pcm_audio is made visible.
function pcm_audio_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pcm_audio (see VARARGIN)
movegui('center');
set(handles.axes1,'Visible','off');
set(handles.axes2,'Visible','off');
% Choose default command line output for pcm_audio
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pcm_audio wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pcm_audio_OutputFcn(hObject, eventdata, handles) 
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
     global    input_sig orgnal_sampl_freq
player1 = audioplayer(input_sig,orgnal_sampl_freq);
    
    % Play signal from beginning to end (no overlap with other code possible).
    playblocking(player1);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
     
     global reconst_sig orgnal_sampl_freq
     player = audioplayer(reconst_sig,orgnal_sampl_freq);
    
    % Play signal from beginning to end (no overlap with other code possible).
    playblocking(player);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1,'reset');
set(handles.axes1,'Visible','off');
cla(handles.axes2,'reset');
set(handles.axes2,'Visible','off');

set(handles.text8,'string','');
set(handles.text9,'string','');
set(handles.text10,'string','');
set(handles.text22,'string','');
set(handles.text24,'string','');






function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sampled_signal h1 h2 h3 h4 quantiz_signal dec_val
global reconst_sig
 global orgnal_sampl_freq input_sig
h1='o';
    h2='o';
    h3='o';
    h4='o';
    h5='o';
   tic; 

word_length = str2num(get(handles.edit1, 'String'))
fs = str2num(get(handles.edit2, 'String'))
[input_sig orgnal_sampl_freq]=audioread('z3.wav');
nbits = audioinfo('z3.wav')
message=nbits.BitsPerSample
TotalSamples=nbits.TotalSamples
 
%========Used later to create a window using 'figure' function========
scrsz = get(0,'ScreenSize');                                                %get dimension of screen
 
 
%=================================================================
 
[a,~]=size(input_sig);
time=(a/orgnal_sampl_freq);
fs=round(fs*time);
  
%===================SAMPLING======================================
 
 
 
samples=round(linspace(1,a,fs));                                               %To get n samples we divide data by n-1 so to get n points(samples)    %Input signal divided into samples with each sample separated by sample_size
sampled_signal=zeros(1,fs);                                                 
index=1;
 
for i=samples
        
    sampled_signal(index)=input_sig(i);
    index=index+1;
    
end
 
 
%===========Begin Quantization==============================
vmax=.5;                                                                     %get upper limit of quantization
vmin=-0.5;                                                                    %get lower limit of quantization
lsb=(vmax-vmin)/((2^word_length)-1);                                        %concept-if we divide a line segment in 2 parts  we get three points
levels=vmin:lsb:vmax;                                                     %generate level vector
 
partition=(vmin-(.5*lsb)):lsb:(vmax+(.5*lsb));                              %introduce +(-)1/2*LSB into levels
[~,index_levels]=size(levels);
 
%========generate quantized value out of sample data =========
 
quantiz_signal=zeros(1,index-1);                                            %index-1??? see previous for loop, there index value exceeds size of sampled_signal in the last iteration
 
for i=1:index-1                                                             %to increment the sampled_signal vector
 
    for j=1:index_levels                                                    %to increment the 'partition' & 'levels' vectors
  %============check if input is less than vmin============================================================
        if (sampled_signal(i)<partition(1))                                 %Compare sample with upper and lower partition of a level
                                                                            %if sample is between partitions, give that value of level to 
                                                                            %the quantize_signal array at the index equal to that of sample.
             quantiz_signal(i)=vmin;                                        %This will generate quantized array of same size of sample's array
             bin_val=dec2bin(0,word_length);                                %for example- In 4-bit PCM quantize level 1 corresponds to 0x0 & level 16 is eqv to 0xf         
         
              
                                                                            %Following commands to arrange string bits columnwise and put it at appropriate index of data stream
         
              val_rearrange=bin_val(:);                                     %Make it i:1 matrix 
              rearrange_index=((i-1)*word_length)+1;                        %Example- for 4 bit insert at 1st,5th,9th,13th..index
              data_stream(rearrange_index:(rearrange_index+word_length-1),1)=val_rearrange;
        end
 %==============check if input is greater than vmax===========================================================
        if (sampled_signal(i)>partition(end))
            
            quantiz_signal(i)=vmax;
             bin_val=dec2bin((2^word_length)-1,word_length);                %for example- In 4-bit PCM quantize level 1 corresponds to 0x0 & level 16 is eqv to 0xf         
         
              
                                                                            %Following commands to arrange string bits columnwise and put it at appropriate index of data stream
         
              val_rearrange=bin_val(:);                                     %Make it i:1 matrix 
              rearrange_index=((i-1)*word_length)+1;                        %Example- for 4 bit insert at 1st,5th,9th,13th..index
              data_stream(rearrange_index:(rearrange_index+word_length-1),1)=val_rearrange;
        end
 %=========================================================================       
        
        if (sampled_signal(i)>=partition(j))
             if (sampled_signal(i)<partition(j+1))
                quantiz_signal(i)=levels(j);
       
                
 %=====Simultaneously generating binary stream for each quantized value====
              bin_val=dec2bin(j-1,word_length);                             %for example- In 4-bit PCM quantize level 1 corresponds to 0x0 & level 16 is eqv to 0xf         
         
              
                                                                            %Following commands to arrange string bits columnwise and put it at appropriate index of data stream
         
              val_rearrange=bin_val(:);                                     %Make it i:1 matrix 
              rearrange_index=((i-1)*word_length)+1;                        %Example- for 4 bit insert at 1st,5th,9th,13th..index
              data_stream(rearrange_index:(rearrange_index+word_length-1),1)=val_rearrange;
              
            
                         
                
             end
        end
        
    end
end
%==========================================================================
 
[size_data,~]=size(data_stream);
 
%=================create Encoded data stream array ========================
%==============Encoded according to Natural Binary Coding==================
dec_val=zeros(size_data,1);
for i=1:size_data
dec_val(i,1)=str2double(data_stream(i,1));                                  %cant plot string array. so convert to numbers
end
 
 
%===========================Decoding=======================================
 
k=1;
 
for i=1:length(data_stream)/word_length                                     %Arrange data stream into word_length sized binary strings for conversion
    for j=1:1:word_length
        bin_rearrange(i,j)=data_stream(k);                                  %Ignoring this Warning!!!!
        k=k+1;
    end
end
bin_rearrange
bin_dec=bin2dec(bin_rearrange);
decoded_val=zeros(length(bin_dec),1);
for i=1:length(bin_dec)                                                     %bin_dec contain dec equivalents ranging from 0 to max for the word
decoded_val(i)=levels(bin_dec(i)+1);                                        %therefore dec equivalent 0 corresponds to level 1.
                                                                            %thus get quantized values from level(dec.equiv+1) and store in an array
end
 
 
%===========Reconstruction from decoded signal=============================
index=1;
reconst_sig=zeros(a,1);                                                     %reconstructed signal is of same size as input signal
for i=samples
   
    
reconst_sig(i,1)=decoded_val(index,1);
index=index+1;
    
end    
 
disp('Processing done');
toc;
axes(handles.axes1);
%h1=figure('Name','Input Signal','NumberTitle','off','Position',[122 scrsz(4)/3 scrsz(3)/2.2 scrsz(4)/2.2]); %Position figure accordingly
set(handles.text8,'String',num2str(orgnal_sampl_freq));
set(handles.text9,'String',num2str(TotalSamples));
set(handles.text10,'String',num2str(message));

plot(input_sig);
title('Input Signal');
ylabel('Signal S(t)');
xlabel('Time,s');
zoom on                                                                      %only to customize plot
player1 = audioplayer(input_sig,orgnal_sampl_freq);
    
    % Play signal from beginning to end (no overlap with other code possible).
   playblocking(player1);


%==============Various Plot data========================================== 


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%h2=figure('Name','Sampled Signal','NumberTitle','off','Position',[scrsz(3)/1.8 scrsz(4)/3 scrsz(3)/2.2 scrsz(4)/2.2]);
global sampled_signal
fs = str2num(get(handles.edit2, 'String'))
axes(handles.axes2);
stem(sampled_signal);
title('Sampled Signal');
ylabel('Signal S(t)')
xlabel('Time,s')
set(handles.text24,'String',num2str(fs));

zoom
                                                                         %only to customize plot


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global h1 quantiz_signal
word_length = str2num(get(handles.edit1, 'String'))
if(~ischar(h1))
close(h1);
end
set(handles.text22,'String',num2str(word_length));
axes(handles.axes2);
%h3=figure('Name','Quantized Signal','NumberTitle','off','Position',[122 1 scrsz(3)/2.2 scrsz(4)]);
stairs(quantiz_signal)
%ylim([vmin vmax])
title('Quantized Signal')
                                                                            %only to customize plotset(gca,'YTick',vmin:lsb:vmax)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  %h4=figure('Name','Pulse Code Modulated Stream','NumberTitle','off','Position',[1 scrsz(4)/3 scrsz(3) scrsz(4)/2.5]);
 global dec_val
  stairs(dec_val');
  axes(handles.axes2);
  axis([1 1000 -3 4]);
  set(gca,'YTick',-3:1:4);
  set(gca,'YTicklabel',{' ',' ',' ','0','1',' ',' ',' '});
title('Pulse Code Modulated Stream');
zoom on;


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global reconst_sig h2 h4
if(~ischar(h2))
    close(h2);
    end
    if(~ischar(h4))
    close(h4);
    end
    %h5=figure('Name','Decoded Signal','NumberTitle','off','Position',[scrsz(3)/1.8 scrsz(4)/3 scrsz(3)/2.2 scrsz(4)/2.2]);
    axes(handles.axes2);
    plot(reconst_sig);
    title('Decoded Signal')
    zoom on;
   % grid on;
    %ylim([vmin vmax])
 
