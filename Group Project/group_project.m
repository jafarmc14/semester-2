clc;
clear all;

lib_name = '';

if strcmp(computer, 'PCWIN')
  lib_name = 'dxl_x86_c';
elseif strcmp(computer, 'PCWIN64')
  lib_name = 'dxl_x64_c';
elseif strcmp(computer, 'GLNX86')
  lib_name = 'libdxl_x86_c';
elseif strcmp(computer, 'GLNXA64')
  lib_name = 'libdxl_x64_c';
elseif strcmp(computer, 'MACI64')
  lib_name = 'libdxl_mac_c';
end

% Load Libraries
if ~libisloaded(lib_name)
    [notfound, warnings] = loadlibrary(lib_name, 'dynamixel_sdk.h', 'addheader', 'port_handler.h', 'addheader', 'packet_handler.h', 'addheader', 'group_bulk_read.h');
end

% Control table address
ADDR_MX_TORQUE_ENABLE           = 24;          
ADDR_MX_GOAL_POSITION           = 30;
ADDR_MX_PRESENT_POSITION        = 36;
ADDR_MX_MOVING                  = 32;
ADDR_MX_TORQUE_LIMIT            = 34;

% Data Byte Length
LEN_MX_GOAL_POSITION            = 2;
LEN_MX_PRESENT_POSITION         = 2;
LEN_MX_MOVING                   = 1;

% Protocol version
PROTOCOL_VERSION                = 1.0;          % See which protocol version is used in the Dynamixel

% Default setting
DXL1_ID                         = 1;            
DXL2_ID                         = 2;            
DXL3_ID                         = 3;            
DXL4_ID                         = 4;            
DXL5_ID                         = 5;            
DXL6_ID                         = 6;            
DXL7_ID                         = 7;            
BAUDRATE                        = 1000000;
DEVICENAME                      = 'COM3';       % Check which port is being used on your controller
                                                % ex) Windows: 'COM1'   Linux: '/dev/ttyUSB0' Mac: '/dev/tty.usbserial-*'

TORQUE_ENABLE                   = 1;            % Value for enabling the torque
TORQUE_DISABLE                  = 0;            % Value for disabling the torque

ESC_CHARACTER                   = 'e';          % Key for escaping loop

COMM_SUCCESS                    = 0;            % Communication Success result value
COMM_TX_FAIL                    = -1001;        % Communication Tx Failed

% Initialize PortHandler Structs
% Set the port path
% Get methods and members of PortHandlerLinux or PortHandlerWindows
port_num = portHandler(DEVICENAME);

% Initialize PacketHandler Structs
packetHandler();

% Initialize Groupbulkread Structs
group_num = groupBulkRead(port_num, PROTOCOL_VERSION);

dxl_comm_result = COMM_TX_FAIL;                 % Communication result
dxl_addparam_result = false;                    % AddParam result
dxl_getdata_result = false;                     % GetParam result

dxl_error = 0;                                  % Dynamixel error

index = 1;

% Open port
if (openPort(port_num))
    fprintf('Succeeded to open the port!\n');
else
    unloadlibrary(lib_name);
    fprintf('Failed to open the port!\n');
    input('Press any key to terminate...\n');
    return;
end


% Set port baudrate
if (setBaudRate(port_num, BAUDRATE))
    fprintf('Succeeded to change the baudrate!\n');
else
    unloadlibrary(lib_name);
    fprintf('Failed to change the baudrate!\n');
    input('Press any key to terminate...\n');
    return;
end


% Enable Dynamixel#1 Torque
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL1_ID, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);
dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
if dxl_comm_result ~= COMM_SUCCESS
    fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
elseif dxl_error ~= 0
    fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
else
    fprintf('Dynamixel1 has been successfully connected \n');
end

% Enable Dynamixel#2 Torque
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL2_ID, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);
dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
if dxl_comm_result ~= COMM_SUCCESS
    fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
elseif dxl_error ~= 0
    fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
else
    fprintf('Dynamixel2 has been successfully connected \n');
end

% Enable Dynamixel#3 Torque
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL3_ID, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);
dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
if dxl_comm_result ~= COMM_SUCCESS
    fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
elseif dxl_error ~= 0
    fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
else
    fprintf('Dynamixel3 has been successfully connected \n');
end

% Enable Dynamixel#4 Torque
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL4_ID, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);
dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
if dxl_comm_result ~= COMM_SUCCESS
    fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
elseif dxl_error ~= 0
    fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
else
    fprintf('Dynamixel4 has been successfully connected \n');
end

% Enable Dynamixel#5 Torque
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL5_ID, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);
dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
if dxl_comm_result ~= COMM_SUCCESS
    fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
elseif dxl_error ~= 0
    fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
else
    fprintf('Dynamixel5 has been successfully connected \n');
end

% Enable Dynamixel#6 Torque
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL6_ID, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);
dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
if dxl_comm_result ~= COMM_SUCCESS
    fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
elseif dxl_error ~= 0
    fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
else
    fprintf('Dynamixel6 has been successfully connected \n');
end

% Enable Dynamixel#7 Torque
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL7_ID, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);
dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
if dxl_comm_result ~= COMM_SUCCESS
    fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
elseif dxl_error ~= 0
    fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
else
    fprintf('Dynamixel7 has been successfully connected \n');
end

% Limite Dynamixel#1 Torque
write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL1_ID, ADDR_MX_TORQUE_LIMIT, 60);
dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
if dxl_comm_result ~= COMM_SUCCESS
    fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
elseif dxl_error ~= 0
    fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
end

% Limite Dynamixel#2 Torque
write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL2_ID, ADDR_MX_TORQUE_LIMIT, 60);
dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
if dxl_comm_result ~= COMM_SUCCESS
    fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
elseif dxl_error ~= 0
    fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
end

% Limite Dynamixel#3 Torque
write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL3_ID, ADDR_MX_TORQUE_LIMIT, 60);
dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
if dxl_comm_result ~= COMM_SUCCESS
    fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
elseif dxl_error ~= 0
    fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
end

% Limite Dynamixel#4 Torque
write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL4_ID, ADDR_MX_TORQUE_LIMIT, 60);
dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
if dxl_comm_result ~= COMM_SUCCESS
    fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
elseif dxl_error ~= 0
    fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
end

% Limite Dynamixel#5 Torque
write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL5_ID, ADDR_MX_TORQUE_LIMIT, 60);
dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
if dxl_comm_result ~= COMM_SUCCESS
    fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
elseif dxl_error ~= 0
    fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
end

% Limite Dynamixel#6 Torque
write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL6_ID, ADDR_MX_TORQUE_LIMIT, 60);
dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
if dxl_comm_result ~= COMM_SUCCESS
    fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
elseif dxl_error ~= 0
    fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
end

% read the present position of dynamixel 1-6
dx_present_position = [read2ByteTxRx(port_num, PROTOCOL_VERSION, DXL1_ID, ADDR_MX_PRESENT_POSITION),
    read2ByteTxRx(port_num, PROTOCOL_VERSION, DXL2_ID, ADDR_MX_PRESENT_POSITION), 
    read2ByteTxRx(port_num, PROTOCOL_VERSION, DXL3_ID, ADDR_MX_PRESENT_POSITION), 
        read2ByteTxRx(port_num, PROTOCOL_VERSION, DXL4_ID, ADDR_MX_PRESENT_POSITION),
        read2ByteTxRx(port_num, PROTOCOL_VERSION, DXL5_ID, ADDR_MX_PRESENT_POSITION),
        read2ByteTxRx(port_num, PROTOCOL_VERSION, DXL6_ID, ADDR_MX_PRESENT_POSITION)];

% check error and print the present position
dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
if dxl_comm_result ~= COMM_SUCCESS
    fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
elseif dxl_error ~= 0
    fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
end
fprintf('PresPos:%03d\n', dx_present_position);

%Give the pick and place points
px=0.2;
py=0;
pz=0.1;
px_f=0.15;
py_f=0;
pz_f=0.1;

%Define the robot
L(1) = Link('d',0,'a',0,'alpha',3*pi/2);
L(2) = Link('d',0,'a',0.0715,'alpha',0);
L(3) = Link('d',0,'a',0.15018,'alpha',3*pi/2);
L(4) = Link('d',0.1312,'a',0,'alpha',pi/2);
L(5) = Link('d',0,'a',0,'alpha',3*pi/2);
L(6) = Link('d',0.076,'a',0,'alpha',0);

bot = SerialLink(L);
bot.name = 'robot';

init_pos = deg2rad(dx_present_position.*[0.088,0.088,0.088,0.29,0.29,0.29]);
%init_pos = deg2rad([2107,2040,1844,464,494,218].*[0.088,0.088,0.088,0.29,0.29,0.29]);
%waypoint1=invkin(bot,px,py,pz+0.1);
waypoint1=deg2rad([1879,2551,1453,503,466,202].*[0.088,0.088,0.088,0.29,0.29,0.29]);
%fin_pos1=invkin(bot,px,py,pz);
%waypoint2=invkin(bot,px_f,py_f,pz_f+0.1);
%fin_pos2=invkin(bot,px_f,py_f,pz_f);
fin_pos1 = deg2rad([2017,2680,1619,483,416,207].*[0.088,0.088,0.088,0.29,0.29,0.29]);
waypoint2=deg2rad([2249,2555,1596,479,447,202].*[0.088,0.088,0.088,0.29,0.29,0.29]);
fin_pos2=deg2rad([2410,2499,1859,510,385,219].*[0.088,0.088,0.088,0.29,0.29,0.29]);
mx_sped = 0.02*ones(1,6);
mx_acc = 0.05*ones(1,6);
num = 600;


%init_pos to waypoint1
[joint, tb, tf] = lspbt(init_pos,waypoint1,mx_sped,mx_acc,num);

joint = fix(rad2deg(joint).*[1/0.088,1/0.088,1/0.088,1/0.29,1/0.29,1/0.29]);
tf = fix(tf);

dxl_goal_position1 = joint(:,1);
dxl_goal_position2 = joint(:,2);
dxl_goal_position3 = joint(:,3);
dxl_goal_position4 = joint(:,4);
dxl_goal_position5 = joint(:,5);
dxl_goal_position6 = joint(:,6);

% the value to close and open the gripper
close_gripper = 200;
open_gripper = 500;

%the movement of manipulator from the present position to waypoint1
for index = 1:num
    % Write Dynamixel#1 goal position
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL1_ID, ADDR_MX_GOAL_POSITION, dxl_goal_position1(index));
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end

    % Write Dynamixel#2 goal position
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL2_ID, ADDR_MX_GOAL_POSITION, dxl_goal_position2(index));
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end

    % Write Dynamixel#3 goal position
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL3_ID, ADDR_MX_GOAL_POSITION, dxl_goal_position3(index));
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end

    % Write Dynamixel#4 goal position
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL4_ID, ADDR_MX_GOAL_POSITION, dxl_goal_position4(index));
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end

    % Write Dynamixel#5 goal position
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL5_ID, ADDR_MX_GOAL_POSITION, dxl_goal_position5(index));
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end

    % Write Dynamixel#6 goal position
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL6_ID, ADDR_MX_GOAL_POSITION, dxl_goal_position6(index));
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end

    if index == 1 %open gripper
        % Write Dynamixel#7 goal position
        write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL7_ID, ADDR_MX_GOAL_POSITION, open_gripper);
        dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
        dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
        if dxl_comm_result ~= COMM_SUCCESS
            fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
        elseif dxl_error ~= 0
            fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
        end
    end


end

%from waypoint1 to fin_pos1
[joint, tb, tf] = lspbt(waypoint1,fin_pos1,mx_sped,mx_acc,num);

joint = fix(rad2deg(joint).*[1/0.088,1/0.088,1/0.088,1/0.29,1/0.29,1/0.29]);
tf = fix(tf);

dxl_goal_position1 = joint(:,1);
dxl_goal_position2 = joint(:,2);
dxl_goal_position3 = joint(:,3);
dxl_goal_position4 = joint(:,4);
dxl_goal_position5 = joint(:,5);
dxl_goal_position6 = joint(:,6);

%the movement of manipulator from waypoint1 to fin_pos1
for index = 1:num

    % Write Dynamixel#1 goal position
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL1_ID, ADDR_MX_GOAL_POSITION, dxl_goal_position1(index));
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end

    % Write Dynamixel#2 goal position
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL2_ID, ADDR_MX_GOAL_POSITION, dxl_goal_position2(index));
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end

    % Write Dynamixel#3 goal position
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL3_ID, ADDR_MX_GOAL_POSITION, dxl_goal_position3(index));
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end

    % Write Dynamixel#4 goal position
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL4_ID, ADDR_MX_GOAL_POSITION, dxl_goal_position4(index));
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end

    % Write Dynamixel#5 goal position
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL5_ID, ADDR_MX_GOAL_POSITION, dxl_goal_position5(index));
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end

    % Write Dynamixel#6 goal position
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL6_ID, ADDR_MX_GOAL_POSITION, dxl_goal_position6(index));
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end

    if index == num %close gripper
        % Write Dynamixel#7 goal position
        write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL7_ID, ADDR_MX_GOAL_POSITION, close_gripper);
        dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
        dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
        if dxl_comm_result ~= COMM_SUCCESS
            fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
        elseif dxl_error ~= 0
            fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
        end
    end


end

%fin_pos1 to waypoint 2
[joint, tb, tf] = lspbt(fin_pos1,waypoint2,mx_sped,mx_acc,num);

joint = fix(rad2deg(joint).*[1/0.088,1/0.088,1/0.088,1/0.29,1/0.29,1/0.29]);
tf = fix(tf);

dxl_goal_position1 = joint(:,1);
dxl_goal_position2 = joint(:,2);
dxl_goal_position3 = joint(:,3);
dxl_goal_position4 = joint(:,4);
dxl_goal_position5 = joint(:,5);
dxl_goal_position6 = joint(:,6);

%the movement of manipulator fin_pos1 to waypoint 2
for index = 1:num

    % Write Dynamixel#1 goal position
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL1_ID, ADDR_MX_GOAL_POSITION, dxl_goal_position1(index));
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end

    % Write Dynamixel#2 goal position
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL2_ID, ADDR_MX_GOAL_POSITION, dxl_goal_position2(index));
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end

    % Write Dynamixel#3 goal position
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL3_ID, ADDR_MX_GOAL_POSITION, dxl_goal_position3(index));
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end

    % Write Dynamixel#4 goal position
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL4_ID, ADDR_MX_GOAL_POSITION, dxl_goal_position4(index));
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end

    % Write Dynamixel#5 goal position
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL5_ID, ADDR_MX_GOAL_POSITION, dxl_goal_position5(index));
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end

    % Write Dynamixel#6 goal position
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL6_ID, ADDR_MX_GOAL_POSITION, dxl_goal_position6(index));
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end
  
end

%from waypoint2 to fin_pos2
[joint, tb, tf] = lspbt(waypoint2,fin_pos2,mx_sped,mx_acc,num);

joint = fix(rad2deg(joint).*[1/0.088,1/0.088,1/0.088,1/0.29,1/0.29,1/0.29]);
tf = fix(tf);

dxl_goal_position1 = joint(:,1);
dxl_goal_position2 = joint(:,2);
dxl_goal_position3 = joint(:,3);
dxl_goal_position4 = joint(:,4);
dxl_goal_position5 = joint(:,5);
dxl_goal_position6 = joint(:,6);


%the movement of manipulator from waypoint2 to fin_pos2
for index = 1:num

    % Write Dynamixel#1 goal position
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL1_ID, ADDR_MX_GOAL_POSITION, dxl_goal_position1(index));
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end

    % Write Dynamixel#2 goal position
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL2_ID, ADDR_MX_GOAL_POSITION, dxl_goal_position2(index));
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end

    % Write Dynamixel#3 goal position
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL3_ID, ADDR_MX_GOAL_POSITION, dxl_goal_position3(index));
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end

    % Write Dynamixel#4 goal position
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL4_ID, ADDR_MX_GOAL_POSITION, dxl_goal_position4(index));
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end

    % Write Dynamixel#5 goal position
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL5_ID, ADDR_MX_GOAL_POSITION, dxl_goal_position5(index));
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end

    % Write Dynamixel#6 goal position
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL6_ID, ADDR_MX_GOAL_POSITION, dxl_goal_position6(index));
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    end

    if index == num %open gripper
        % Write Dynamixel#7 goal position
        write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL7_ID, ADDR_MX_GOAL_POSITION, open_gripper);
        dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
        dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
        if dxl_comm_result ~= COMM_SUCCESS
            fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
        elseif dxl_error ~= 0
            fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
        end
    end


end

% Close port
closePort(port_num);

% Unload Library
unloadlibrary(lib_name);

close all;
