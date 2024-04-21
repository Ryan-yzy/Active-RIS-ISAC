%获取绘图颜色，可自由选择颜色或者预设颜色模板
function [all_themes, all_colors] = GetColors()
% 颜值即正义1
c_string{1} = {'#FD6D5A', '#FEB40B', '#6DC354', '#994487', '#518CD8', '#443295'};
% 颜值即正义2
c_string{2} = {'#264653', '#2A9D8F', '#E9C46A', '#F4A261', '#E76F51', '#253777'};
% 颜值即正义3
c_string{3} = {'#C1C976', '#C8A9A1', '#FEC2E4', '#77CCE0', '#FFD372', '#F88078'};
% 颜值即正义4
c_string{4} = {'#104FFF', '#2FD151', '#64C7B8', '#FF1038', '#45CAFF', '#B913FF'};
% 颜值即正义5
c_string{5} = {'#4C87D6', '#F38562', '#F2B825', '#D4C114', '#88B421', '#199FE0'};
% 颜值即正义6
c_string{6} = {'#037CD2', '#00AAAA', '#927FD3', '#E54E5D', '#EAA700', '#F57F4B'};
% 颜值即正义7
c_string{7} = {'#64B6EA', '#FB8857', '#A788EB', '#80D172', '#FC7A77', '#61D4D5'};
% 颜值即正义8
c_string{8} = {'#F1787D', '#F8D889', '#69CDE0', '#5EB7F1', '#EDA462', '#F6C4E6'};
% 颜值即正义9
c_string{9} = {'#8C8FD5', '#C0E5BC', '#8C8FD5', '#BDF4FC', '#C3BCE6', '#F48FB1'};
% China Mobile
c_string{10} = {'#B04A7A', '#171433', '#B6342E', '#DBB9DB', '#FAB4AC', '#EFB9C1'};
% 波西米亚风情
c_string{11} = {'#E74745', '#FB7857', '#FBCD60', '#FEFB66', '#1AC0C6', '#FB7857'};
% WOF 旺德福
c_string{12} = {'#361D32', '#543C52', '#F65A53', '#EED2CB', '#DBD873', '#F1E8E8'};
% 瑞普演界网
c_string{13} = {'#454D66', '#319975', '#58B368', '#DBD873', '#FAC46C', '#F1ECB7'};
% Georgia Holt
c_string{14} = {'#112E92', '#112E92', '#48D6D2', '#81EAE6', '#F8F6BA', '#E3F5F6'};
% William Alexander
c_string{15} = {'#134036', '#103232', '#34C0B8', '#7A27FF', '#FFCA7B', '#F8A427'};
% 配色1
c_string{16} = {'#FF0000', '#F65A53', '#34C0B8', '#7A27FF', '#FF98A4', '#D7BCE7'};
% 配色2
c_string{17} = {'#F84D4D', '#FF6B42', '#5BA3EB', '#06BB9A', '#8E7EF0', '#F4B919'};
% 配色3
c_string{18} = {'#406196', '#F4B414', '#77649B', '#385D77', '#576270', '#778495'};
% 配色4
c_string{19} = {'#4C6CFF', '#18C1FF', '#3DEF2D', '#9818BC', '#CB1E86', '#FC564B'};
% Reeoo
c_string{20} = {'#0E9DFF', '#FF0000', '#800080', '#FFA500', '#ECE70B', '#979797'};
% Encry
c_string{21} = {'#313BD0', '#9A22F8', '#00F2F2', '#00B2FC', '#5EAFFA', '#81E0D7'};
% 小清新1
c_string{22} = {'#55EFC4', '#81ECEC', '#74B9FF', '#A29BFE', '#7F8C8D', '#C9C9C9'};
% 蓝色精灵
c_string{23} = {'#FAD390', '#F8C291', '#3742FA', '#70A1FF', '#82CCDD', '#B8E994'};
% 单色调
c_string{24} = {'#F8E0F1', '#DEC8CC', '#B87D9C', '#82447F', '#0B174E', '#C9C9C9'};
% Amgen
c_string{25} = {'#0063C3', '#408AD2', '#3396CF', '#A0D284', '#F5CD39', '#BEBEBE'};
% Vectary
c_string{26} = {'#4316F3', '#8769F7', '#FA807C', '#EFC09D', '#A5A5A5', '#C9C9C9'};
% 墨镜
c_string{27} = {'#104382', '#0A8CB2', '#448CE1', '#1BB5E1', '#FF6155', '#C9C9C9'};
% Khan Academy
c_string{28} = {'#14BF96', '#1865F2', '#FFB100', '#073587', '#5F9ABC', '#BCBCBC'};
% 蒲公英
c_string{29} = {'#16B99A', '#1F7CC1', '#1686F8', '#3EC5E0', '#93D06A', '#BABABA'};
% 星珀互动
c_string{30} = {'#014AE0', '#1587FD', '#2DD3FB', '#FA6766', '#F8B613', '#BD55F9'};
% 麦客
c_string{31} = {'#1987D7', '#5B73CD', '#1FBF79', '#3BB9C1', '#F86B0D', '#FAA900'};
% 摸象大数据
c_string{32} = {'#4071EC', '#FA3279', '#1096FA', '#35B9E4', '#2DCC97', '#A0B2BA'};
% 万日出发
c_string{33} = {'#007EB4', '#00A7FC', '#FFC85C', '#ED326C', '#A84269', '#BC4715'};
% 光明使者
c_string{34} = {'#F79F1F', '#A3CB38', '#1289A7', '#D980FA', '#FDA7DF', '#B53471'};
% 冷暖碰撞
c_string{35} = {'#FA983A', '#EB2F06', '#1E3799', '#3C6382', '#38ADA9', '#C9C9C9'};
% 治愈色
c_string{36} = {'#2ED573', '#1E90FF', '#3742FA', '#70A1FF', '#2F3542', '#C9C9C9'};
% 食欲大增
c_string{37} = {'#FC5C65', '#FD9644', '#FED330', '#26DE81', '#079992', '#2BCBBA'};
% 小清新2
c_string{38} = {'#F3A683', '#F7D794', '#778BEB', '#70A1FF', '#E77F67', '#CF6A87'};
% 别致搭配
c_string{39} = {'#F6B93B', '#E55039', '#4A69BD', '#60A3BC', '#78E08F', '#BBEA99'};
% 健康
c_string{40} = {'#00ADD7', '#00668A', '#F1C900', '#FFF1CE', '#E01706', '#C9C9C9'};
% 童年时光
c_string{41} = {'#D3DE9E', '#004965', '#17C0EB', '#FF7F78', '#3D3D3D', '#FFF200'};
% 紫薇色的搭配
c_string{42} = {'#CD84F1', '#FFCCCC', '#FF4D4D', '#FFAF40', '#2F3542', '#FFFA65'};
% 科技时代
c_string{43} = {'#F53B57', '#3C40C6', '#3C40C6', '#00D8D6', '#05C46B', '#C9C9C9'};
% 人生的味道 
c_string{44} = {'#50514F', '#F45E58', '#FFE15B', '#1D7AA2', '#6DC1B3', '#A5B1C2'};
% 狂欢派对
c_string{45} = {'#FFC312', '#12CBC4', '#C4E538', '#1289A7', '#FDA7DF', '#ED4C67'};
% 校园时光
c_string{46} = {'#FFC000', '#EA3C6E', '#1B73A7', '#2C946E', '#A5B1C2', '#303952'};
% 急需休息
c_string{47} = {'#A589C6', '#FD91A0', '#F2E9DA', '#DFE384', '#39BFCB', '#A6E3E8'};
% 平淡如水
c_string{48} = {'#CC99FF', '#FFAFD7', '#9BCDFF', '#FFD0A1', '#99FFCC', '#CCFF9A'};
% 绚丽多彩
c_string{49} = {'#3F48CC', '#B83DBA', '#FF7F27', '#0ED145', '#EC1C24', '#A76E4E'};
% 苍茫一色
c_string{50} = {'#385261', '#7298AB', '#4F9A73', '#74878B', '#86AEA6', '#D1F0F3'};
% 高级红
c_string{51} = {'#ED5736', '#C61D34', '#F30D00', '#DD5A6C', '#F00057', '#FE0096'};
% 高级蓝
c_string{52} = {'#4B59C2', '#5A77BB', '#4A94C5', '#3B2E7E', '#013370', '#1A2946'};
% 高级绿
c_string{53} = {'#08DE9E', '#01E400', '#21A576', '#BDDD20', '#9DBC20', '#67945B'};
% 高级紫
c_string{54} = {'#7F1EAC', '#815377', '#57004F', '#4C211B', '#CBA4E5', '#A5A9D6'};
% 高级深色
c_string{55} = {'#2D445F', '#3F4D50', '#494263', '#2279B6', '#7B9067', '#B56B62'};
% 中国瓷1
c_string{56} = {'#101420', '#4C000A', '#1A5599', '#8E2961', '#407D53', '#8E2961'};
% 中国瓷2
c_string{57} = {'#0095B6', '#4FA485', '#81D8D0', '#E2AF42', '#B8CE8E', '#9AB4CD'};
% 小清新3
c_string{58} = {'#005EAD', '#AF6DE5', '#719FFB', '#1CAC99', '#FE9499', '#4A8FDE'};
% 小清新4
c_string{58} = {'#4DE890', '#2178B8', '#77A2E8', '#F86067', '#26C4B8', '#0094C5'};
% 小清新5
c_string{58} = {'#5AE7E4', '#2E9F79', '#3638AE', '#FF7F00', '#FA9B97', '#30A02D'};
% 小清新6
c_string{58} = {'#B0E188', '#2077B5', '#05B9C7', '#A8CBE4', '#F5FFB3', '#BEECAF'};
% 小清新7
c_string{59} = {'#FFA1C4', '#8770E0', '#01AFEE', '#4574C6', '#FDC100', '#BAD0C4'};
% 眼前一亮
c_string{60} = {'#4AB9EE', '#FF178D', '#FF178D', '#FFD600', '#00B1A1', '#97D601'};
% 十六进制转成RGB颜色
% 获取所有的颜色
m_count = length(c_string);
c_count = sum(cellfun(@length, c_string));
all_colors = nan(c_count, 3);
all_themes = cell(m_count, 1);
idx = 1;
for i = 1 : length(c_string)
    color = nan(length(c_string{i}), 3);
    for j = 1 : length(c_string{i})
        % 注意这里的RGB值是0-255范围
        rgb = Hex2RGB(c_string{i}{j});
        all_colors(idx, :) = RGB2MatlabColor(rgb);
        color(j, :) = all_colors(idx, :);
        idx = idx + 1;
    end
    all_themes{i} = color;
end
end