clear all;
a = arduino();
led_rojo = 'D10';
led_verde = 'D9';
 
contador = 0;
 
%% Programa
hWaitbar = waitbar(0, 'Interaction 1', 'Name', 'Solvin problem', ...
            	'CreateCanceBtn', 'delete(gcbf)');    	
i = 0;       	
cam = webcam('Logitech HD Webcam C270');

faceDetector = vision.CascadeObjectDetector;
faceDetector.MergeThreshold = 3;
 
while 1
    	O = snapshot(cam);

    	bboxes = faceDetector(O);
    	IFaces = insertObjectAnnotation(O,'rectangle',bboxes,'Face'); 
    
    	subplot(1,2,1);
    	imshow(O)
    	
    	subplot(1,2,2);
    	imshow(IFaces)
    	
    	if sum(bboxes) > 1
        	contador = 1;
    	else
        	contador = 2;
    	end
    	
    	if contador == 1
        	writeDigitalPin(a,led_rojo,0);
        	writeDigitalPin(a,led_verde,1);
    	end
    	if contador == 2
        	writeDigitalPin(a,led_verde,0);
        	writeDigitalPin(a,led_rojo,1);
    	end

        	if ~ishandle(hWaitbar)
             	disp('Detenido')
             	break
          	else
             	waitbar(i/5, hWaitbar, ['Interation' num2str(i)])
        	end
     	i = i + 1;
     	pause(0.01);
end
clear cam
close all force
