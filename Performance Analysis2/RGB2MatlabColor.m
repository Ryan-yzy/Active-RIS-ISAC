%RGB值转化为Matlab颜色向量
function c = RGB2MatlabColor(rgb)
c = round(100 * rgb/255) / 100;
end