pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
--sonic 2.5
--by bonevolt

function spl_unp(s)
 return unpack(split(s))
end

poke(0x5f5c,255)

--memset(0x4300,0,0x1b00)
poke(0x5f2e,1)

--old room size 24*128=3072
--ehz1 size 52*686=35672
--ehz is 11.6 time bigger than the old room

--[[
bt={}
b_rec=--{press},{release}
{
--⬅️
[0]={{[265]=true},{[300]=true}},
--➡️
{{[1]=true,[300]=true},{[260]=true,[600]=true}},
--⬆️
{{},{}},
--⬇️
{{},{}},
--🅾️
{{[30]=true,[193]=true,[450]=true},{[60]=true,[200]=true,[451]=true}},
--❎
{{},{}},
}
obtn=btn
obtnp=btnp
function btnp(b)
 return obtnp(b) or b_rec[b][1][dt]
end
function btn(b)
 if (b_rec[b][1][dt]) bt[b]=true
 if (b_rec[b][2][dt]) bt[b]=false
 return obtn(b) or bt[b]
end
--]]

obtn=btn
obtnp=btnp
function btn(b)
 return obtn(b,0) or obtn(b,1)
end
function btnp(b)
 return obtnp(b,0) or obtnp(b,1)
end

-- Add after the initial setup code, before the t_height table
frame_count = 0 
recording = false

-- Add recording functions
function record_frame()
    -- Get inputs as a bitfield
    local inputs = 0
    inputs |= btn(⬅️) and 1 or 0     -- left
    inputs |= (btn(➡️) and 1 or 0) << 1  -- right 
    inputs |= (btn(⬆️) and 1 or 0) << 2  -- up
    inputs |= (btn(⬇️) and 1 or 0) << 3  -- down
    inputs |= (btn(🅾️) and 1 or 0) << 4  -- z/o button
    inputs |= (btn(❎) and 1 or 0) << 5  -- x/x button

    -- Build binary data string
    local data = ""
    -- Frame number (4 bytes)
    for i=0,3 do
        data ..= chr(frame_count >> (i*8) & 0xff)
    end
    -- Input bitfield (1 byte)
    data ..= chr(inputs)
    
    -- Pixel data (128x128 pixels packed 2 per byte)
    for y=0,127 do
        for x=0,127,2 do
            local p1 = pget(x,y)
            local p2 = pget(x+1,y)
            data ..= chr((p1 << 4) | p2)
        end
    end
    
    -- Save binary data (@ prefix tells printh to write raw bytes)
    printh("@"..data, "sonic_data.bin", true)
    frame_count += 1
end

--solids
t_height=
{
[6]={8,8,8,8,8,8,8,8},
[21]={8,8,8,8,8,8,8,8},
[22]={8,8,8,8,8,8,8,8},
[35]={8,8,8,8,8,8,8,8},
[36]={8,8,8,8,8,8,8,8},
[37]={8,8,8,8,8,8,8,8},
[55]={8,8,8,8,8,8,8,8},
[100]={8,8,8,8,8,8,8,8},
[101]={8,8,8,8,8,8,8,8},
[116]={8,8,8,8,8,8,8,8},
[117]={8,8,8,8,8,8,8,8},
[87]={8,8,8,8,8,8,8,8},
[104]={8,8,8,8,8,8,8,8},
[105]={8,8,8,8,8,8,8,8},
[120]={8,8,8,8,8,8,8,8},
[121]={8,8,8,8,8,8,8,8},
[222]={8,8,8,8,8,8,8,8},
[235]={8,8,8,8,8,8,8,8},
[236]={8,8,8,8,8,8,8,8},
[62]={8,8,8,8,8,8,8,8},

--semi-solid
[237]={8,8,8,8,8,8,8,8},

--acid
[69]={6,6,6,6,6,6,6,6},
[68]={8,8,8,8,8,8,8,8},

[52]={1,1,1,1,1,1,2,2},
[53]={2,2,2,3,3,3,4,4},
[54]={5,5,6,6,7,8,8,8},
[38]={0,0,0,0,0,0,1,2},
[39]={3,4,5,6,7,8,8,8},
[23]={0,0,0,0,1,2,3,4},
[7]={0,0,0,0,0,0,1,2},

[71]={1,1,1,0,0,0,0,0},
[20]={8,8,8,8,8,8,8,8},
[84]={8,8,8,8,8,8,8,8},
[85]={8,8,8,8,8,8,8,8},
[86]={8,8,8,8,8,8,8,8},

[112]={1,1,1,1,1,1,2,2},
[113]={2,2,2,3,3,3,4,4},
[114]={5,5,6,6,7,8,8,8},
[98]={0,0,0,0,0,0,1,2},
[99]={3,4,5,6,7,8,8,8},
[83]={0,0,0,0,1,2,3,4},
[67]={0,0,0,0,0,0,1,2},

[179]={0,0,0,0,0,0,1,2},
[163]={0,0,0,0,1,2,3,4},
[147]={3,4,5,6,7,8,8,8},
[146]={0,0,0,0,0,0,1,2},
[130]={5,5,6,6,7,8,8,8},
[129]={2,2,2,3,3,3,4,4},
[128]={1,1,1,1,1,1,2,2},

[136]={2,2,1,1,1,1,1,1},
[135]={4,4,3,3,3,2,2,2},
[134]={8,8,8,7,6,6,5,5},
[150]={2,1,0,0,0,0,0,0},
[149]={8,8,8,7,6,5,4,3},
[165]={4,3,2,1,0,0,0,0},
[181]={2,1,0,0,0,0,0,0},

[138]={2,1,0,0,0,0,0,0},
[154]={4,3,2,1,0,0,0,0},
[170]={8,8,8,7,6,5,4,3},
[171]={2,1,0,0,0,0,0,0},
[187]={8,8,8,7,6,6,5,5},
[188]={4,4,3,3,3,2,2,2},
[189]={2,2,1,1,1,1,1,1},
}

t_width=
{
[6]={8,8,8,8,8,8,8,8},
[21]={8,8,8,8,8,8,8,8},
[22]={8,8,8,8,8,8,8,8},
[35]={8,8,8,8,8,8,8,8},
[36]={8,8,8,8,8,8,8,8},
[37]={8,8,8,8,8,8,8,8},
[55]={8,8,8,8,8,8,8,8},
[100]={8,8,8,8,8,8,8,8},
[101]={8,8,8,8,8,8,8,8},
[116]={8,8,8,8,8,8,8,8},
[117]={8,8,8,8,8,8,8,8},
[87]={8,8,8,8,8,8,8,8},
[104]={8,8,8,8,8,8,8,8},
[105]={8,8,8,8,8,8,8,8},
[120]={8,8,8,8,8,8,8,8},
[121]={8,8,8,8,8,8,8,8},
[222]={8,8,8,8,8,8,8,8},
[235]={8,8,8,8,8,8,8,8},
[236]={8,8,8,8,8,8,8,8},
[62]={8,8,8,8,8,8,8,8},

--semi-solid
[237]={0,0,0,0,0,0,0,0},

--acid
[69]={0,0,8,8,8,8,8,8},
[68]={8,8,8,8,8,8,8,8},

[52]={0,0,0,0,0,0,1,2},
[53]={0,0,0,0,1,2,3,4},
[54]={3,4,5,6,7,8,8,8},
[38]={0,0,0,0,0,0,1,2},
[39]={5,5,6,6,7,8,8,8},
[23]={2,2,2,3,3,3,4,4},
[7]={1,1,1,1,1,1,2,2},

[71]={0,0,0,0,0,0,0,3},

[20]={8,8,8,8,8,8,8,8},
[84]={8,8,8,8,8,8,8,8},
[85]={8,8,8,8,8,8,8,8},
[86]={8,8,8,8,8,8,8,8},

[112]={0,0,0,0,0,0,1,2},
[113]={0,0,0,0,1,2,3,4},
[114]={3,4,5,6,7,8,8,8},
[98]={0,0,0,0,0,0,1,2},
[99]={5,5,6,6,7,8,8,8},
[83]={2,2,2,3,3,3,4,4},
[67]={1,1,1,1,1,1,2,2},

[179]={2,2,1,1,1,1,1,1},
[163]={4,4,3,3,3,2,2,2},
[147]={8,8,8,7,6,6,5,5},
[146]={2,1,0,0,0,0,0,0},
[130]={8,8,8,7,6,5,4,3},
[129]={4,3,2,1,0,0,0,0},
[128]={2,1,0,0,0,0,0,0},

[136]={2,1,0,0,0,0,0,0},
[135]={4,3,2,1,0,0,0,0},
[134]={8,8,8,7,6,5,4,3},
[150]={2,1,0,0,0,0,0,0},
[149]={8,8,8,7,6,6,5,5},
[165]={4,4,3,3,3,2,2,2},
[181]={2,2,1,1,1,1,1,1},

[138]={1,1,1,1,1,1,2,2},
[154]={2,2,2,3,3,3,4,4},
[170]={5,5,6,6,7,8,8,8},
[171]={0,0,0,0,0,0,1,2},
[187]={3,4,5,6,7,8,8,8},
[188]={0,0,0,0,1,2,3,4},
[189]={0,0,0,0,0,0,1,2},
}

t_ang=
{
[6]=0,
[21]=0,
[22]=0,
[35]=0,
[36]=0,
[37]=0,
[55]=0,
[100]=0,
[101]=0,
[116]=0,
[117]=0,
[87]=0,
[104]=0,
[105]=0,
[120]=0,
[121]=0,
[222]=0,
[235]=0,
[236]=0,
[62]=0,

--semi-solid
[237]=0,

--acid
[69]=0,
[68]=0,

[52]=0x.08,
[53]=0x.1,
[54]=0x.18,
[38]=0x.2,
[39]=0x.28,
[23]=0x.3,
[7]=0x.38,

[71]=0,
[20]=0,
[84]=0,
[85]=0,
[86]=0,

[112]=0x.08,
[113]=0x.1,
[114]=0x.18,
[98]=0x.2,
[99]=0x.28,
[83]=0x.3,
[67]=0x.38,

[179]=0x.48,
[163]=0x.5,
[147]=0x.58,
[146]=0x.6,
[130]=0x.68,
[129]=0x.7,
[128]=0x.78,

[136]=0x.88,
[135]=0x.9,
[134]=0x.98,
[150]=0x.a,
[149]=0x.a8,
[165]=0x.b,
[181]=0x.b8,

[138]=0x.c8,
[154]=0x.d,
[170]=0x.d8,
[171]=0x.e,
[187]=0x.e8,
[188]=0x.f,
[189]=0x.f8,
}

checked={}
for i=-10,16 do
 checked[i]={}
end

s_clr=
{
{[0]=7,12,0,8,9},
{[0]=7,13,1,0,14},
{[0]=7,13,10,11,3},
{[0]=7,6,5,5,4},
{[0]=6,5,4,3,2},
{[0]=12,14,8,9,2},
{[0]=7,6,6,4,4},
}

--grid=split("128,30,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,0,0,0,0,0,20,20,149,165,181,0,0,138,154,170,85,20,20,20,149,165,181,0,0,0,138,154,170,85,20,0,0,0,0,0,20,134,150,0,0,0,0,0,0,171,187,20,20,134,150,0,0,0,0,0,0,0,171,187,20,0,0,0,0,0,20,135,0,0,0,0,0,0,0,0,188,85,20,135,0,0,0,0,0,0,0,0,0,188,85,0,0,0,0,0,20,136,0,0,0,0,0,0,0,0,189,84,20,136,0,0,0,0,0,0,0,0,0,189,22,0,0,0,0,0,20,0,0,0,0,0,0,0,0,238,254,84,20,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,20,0,0,0,0,0,0,0,0,239,255,84,20,0,0,0,0,0,0,0,0,0,238,254,6,0,0,0,0,0,20,0,0,0,0,0,0,0,0,0,0,84,20,0,0,0,0,0,0,0,0,0,239,255,22,0,0,0,0,0,20,0,0,0,0,0,0,0,0,0,0,84,20,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,20,0,0,0,0,0,0,0,0,0,0,84,20,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,20,128,0,0,0,0,0,0,0,0,0,84,20,0,0,0,0,0,0,0,0,0,0,52,22,0,0,0,0,0,20,129,0,0,0,0,84,20,20,20,20,20,20,0,0,0,0,0,0,0,0,0,0,53,6,0,0,0,0,0,20,130,146,0,0,0,0,138,154,170,85,20,20,0,0,0,0,0,0,0,0,0,38,54,6,0,0,0,0,0,20,20,147,163,179,0,0,0,0,171,187,20,20,0,0,0,0,0,0,0,7,23,39,55,22,0,0,0,0,0,20,20,20,20,20,20,0,0,0,0,188,85,20,0,0,0,0,0,0,22,21,37,37,37,36,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,189,84,20,0,0,0,0,0,0,6,21,100,116,21,116,0,0,0,0,0,16,32,48,0,0,0,0,0,0,0,0,84,20,0,0,0,0,0,0,6,21,101,117,21,117,0,0,0,0,0,17,33,49,0,0,0,0,0,0,0,0,84,20,0,0,0,0,0,0,22,21,37,37,36,20,0,0,0,0,0,18,34,50,0,0,0,0,0,0,0,0,84,20,0,0,0,0,0,0,22,21,20,100,116,20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,84,20,0,0,0,0,0,0,6,21,20,101,117,20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,84,20,0,0,0,0,0,0,6,21,20,20,20,20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,84,20,0,0,0,0,0,0,22,21,20,20,20,20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,84,20,0,0,0,0,0,0,0,0,0,84,20,20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,84,20,0,0,0,0,0,0,0,0,0,84,20,20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,84,20,0,0,0,0,0,0,0,238,254,84,20,20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,112,84,20,128,0,0,0,0,0,0,239,255,84,20,20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,113,86,20,129,0,0,0,0,0,0,0,0,84,20,20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,98,114,20,20,130,146,0,0,0,0,0,0,0,84,20,20,0,0,0,0,0,0,0,0,0,0,0,0,67,83,99,86,20,20,20,147,0,0,0,0,0,0,0,84,20,20,0,0,0,0,0,0,0,0,0,0,0,0,84,20,20,20,20,20,0,0,0,0,0,0,71,170,85,20,20,20,0,0,0,0,0,0,0,0,0,0,0,0,84,20,20,20,20,20,0,0,0,0,0,0,0,171,187,20,20,20,0,0,0,0,0,0,0,0,0,0,0,0,84,20,100,116,100,116,0,0,0,0,0,0,0,0,188,85,20,20,0,0,0,0,0,0,0,0,0,0,0,0,84,20,101,117,101,117,0,0,0,0,0,0,0,0,189,84,20,20,0,0,0,0,0,0,0,0,0,0,0,0,84,20,20,20,20,20,0,0,0,0,0,0,0,238,254,84,20,20,0,0,0,0,0,0,0,0,0,0,0,0,84,100,116,100,116,20,0,0,0,0,0,0,0,239,255,84,20,20,0,0,0,0,0,0,0,0,0,0,0,0,84,101,117,101,117,20,0,0,0,0,0,0,0,0,0,84,20,20,0,0,0,0,0,0,0,0,0,0,0,0,84,20,20,20,20,20,0,0,0,0,0,0,0,0,0,22,100,116,0,0,0,0,0,0,0,0,0,0,0,0,0,0,22,21,36,0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,21,36,0,0,0,0,0,0,0,0,0,0,84,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,21,36,0,0,0,0,0,0,0,0,0,0,84,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,22,21,36,0,0,0,0,0,0,0,0,0,0,84,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,21,36,0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,101,117,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,37,36,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,22,21,21,0,0,0,0,0,20,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,112,84,20,20,0,0,0,0,0,20,129,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,113,86,20,20,0,0,0,0,0,20,130,146,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,98,114,20,20,20,0,0,0,0,0,20,20,147,163,179,0,0,0,0,0,0,0,0,0,0,0,0,0,67,83,99,86,20,20,20,0,0,0,0,0,20,20,20,20,20,20,0,0,0,0,84,20,20,20,20,20,20,20,20,20,20,20,20,20,20,0,0,0,0,0,20,20,20,20,20,20,0,0,0,0,84,20,20,20,20,20,20,20,20,20,20,20,20,20,20,0,0,0,0,0,35,35,100,116,35,35,51,51,51,51,22,21,100,116,35,35,35,35,21,21,35,35,35,35,35,0,0,0,0,0,35,35,101,117,35,35,51,51,51,51,6,21,101,117,35,35,35,35,21,21,35,35,35,35,35,0,0,0,0,0,35,35,51,51,35,35,51,51,51,51,6,21,100,36,37,36,35,35,21,21,35,35,20,20,35,0,0,0,0,0,35,35,51,51,35,35,51,51,51,51,22,21,101,36,37,36,35,35,21,21,35,35,20,20,35,0,0,0,0,0,35,35,100,116,35,35,51,51,51,51,22,21,36,37,37,37,37,37,36,100,116,21,20,20,20,0,0,0,0,0,35,35,101,117,35,35,51,51,51,51,6,21,36,37,37,37,37,37,36,101,117,21,20,20,20,0,0,0,0,0,35,35,51,51,35,35,51,51,51,51,6,21,100,116,35,35,35,35,35,35,35,35,20,20,20,0,0,0,0,0,35,35,51,51,35,35,51,51,51,51,22,21,101,117,35,35,35,35,35,35,35,35,20,20,20,0,0,0,0,0,20,20,149,165,181,0,51,51,51,51,51,51,0,0,0,0,0,0,0,138,154,170,85,20,20,0,0,0,0,0,20,134,150,0,0,0,51,51,51,51,51,51,0,0,0,0,0,0,0,0,0,171,187,20,20,0,0,0,0,0,20,135,0,0,0,0,51,51,51,51,6,21,36,37,37,36,0,0,0,0,0,0,188,85,20,20,20,20,20,20,20,136,0,0,0,0,51,51,51,51,22,21,36,37,37,36,0,0,0,0,0,0,189,84,20,20,20,20,20,20,20,0,0,0,0,0,0,0,0,0,22,21,51,51,0,0,0,0,0,0,0,0,0,84,20,20,20,20,20,20,20,0,0,0,0,0,0,0,0,0,6,21,51,51,0,0,0,0,0,0,0,0,0,84,20,20,20,20,20,20,20,0,0,0,0,0,0,0,0,0,6,21,100,116,0,0,0,0,0,0,0,0,0,84,20,20,20,20,20,20,20,0,0,0,0,0,0,0,0,0,22,21,101,117,0,0,0,0,0,0,0,0,0,84,20,20,20,20,20,20,20,128,0,0,0,0,0,0,0,52,22,21,35,35,0,0,0,0,0,0,0,0,0,84,20,20,20,20,20,20,20,129,0,0,0,0,0,0,0,53,6,21,35,35,0,0,0,0,0,0,0,0,0,84,20,20,20,20,20,20,20,130,146,0,0,0,0,0,38,54,6,21,35,35,0,0,0,0,0,0,0,0,0,21,20,20,20,20,20,20,20,20,147,163,179,0,7,23,39,55,22,21,35,35,0,0,0,0,0,0,0,0,0,21,20,20,20,20,20,20,22,21,35,35,35,35,100,116,35,35,51,51,51,51,0,0,0,0,0,0,0,0,0,21,20,0,0,0,0,0,6,21,35,35,35,35,101,117,35,35,51,51,51,51,0,0,0,0,0,0,0,0,0,21,20,0,0,0,0,0,6,21,35,35,35,35,36,37,37,37,37,37,37,37,36,0,0,0,0,0,0,0,52,21,35,0,0,0,0,0,22,21,35,35,35,35,36,37,37,37,37,37,37,37,36,0,0,0,0,0,0,0,53,21,35,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,38,54,21,35,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,23,39,55,21,35,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,22,21,35,35,100,116,35,35,35,35,35,35,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,21,35,35,101,117,35,35,35,35,35,35,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,21,35,35,100,116,35,35,35,35,35,35,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,22,21,35,35,101,117,35,35,35,35,35,35,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,22,21,100,116,35,35,35,35,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,21,101,117,35,35,35,35,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,21,100,116,35,35,35,35,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,22,21,101,117,35,35,35,35,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,22,21,35,35,35,35,35,35,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,21,35,35,35,35,35,35,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,21,35,35,35,35,35,35,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,22,21,35,35,35,35,35,35,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,69,68,68,68,68,68,68,68,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,69,68,68,68,68,68,68,68,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,69,68,68,68,68,68,68,68,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,69,68,68,68,68,68,68,68,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,69,68,68,68,68,68,68,68,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,69,68,68,68,68,68,68,68,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,69,68,68,68,68,68,68,68,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,69,68,68,68,68,68,68,68,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,69,68,68,68,68,68,68,68,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,69,68,68,68,68,68,68,68,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,69,68,68,68,68,68,68,68,0,0,0,0,0,0,0,0,0,0,22,21,36,0,0,0,0,0,0,0,0,0,69,68,68,68,68,68,68,68,0,0,0,0,0,0,0,0,0,0,6,21,36,0,0,0,0,0,0,0,0,0,69,68,68,68,68,68,68,68,0,0,0,0,0,0,0,0,0,0,6,21,36,0,0,0,0,0,0,0,0,0,69,68,68,68,68,68,68,68,0,0,0,0,0,0,0,0,0,0,22,21,36,0,0,0,0,0,0,0,0,0,69,68,68,68,68,68,68,68,0,0,0,0,0,0,0,0,0,0,22,21,36,0,0,0,0,0,0,0,0,0,69,68,68,68,68,68,68,68,0,0,0,0,0,0,0,0,0,0,6,21,35,0,0,0,0,0,0,0,0,0,69,68,68,68,68,68,68,68,0,0,0,0,0,0,0,0,0,0,6,21,35,0,0,0,0,0,0,0,0,0,69,68,68,68,68,68,68,68,0,0,0,0,0,0,0,0,0,0,22,21,35,0,0,0,0,0,0,0,0,0,69,68,68,68,68,68,68,68,0,0,0,0,0,0,0,22,21,36,37,21,36,37,37,0,0,0,0,0,0,0,22,21,35,35,35,35,35,35,0,0,0,0,0,0,0,6,21,35,35,21,35,35,35,0,0,0,0,0,0,0,6,21,37,37,37,37,37,36,0,0,0,0,0,0,0,6,21,35,35,21,35,35,35,0,0,0,0,0,0,0,6,21,37,37,37,37,37,36,0,0,0,0,0,0,0,22,21,36,37,21,36,37,37,0,0,0,0,0,0,0,22,21,35,35,35,35,35,35,0,0,0,0,0,0,0,22,21,100,116,21,100,116,21,0,0,0,0,0,0,0,22,21,35,35,35,35,35,35,0,0,0,0,0,0,0,6,21,101,117,21,101,117,21,0,0,0,0,0,0,0,6,21,35,35,35,35,35,35,0,0,0,0,0,0,0,6,21,36,37,21,36,37,21,0,0,0,0,0,0,0,6,21,37,37,37,37,37,36,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,22,21,35,35,35,35,35,35,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,22,21,35,35,35,35,35,35,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,52,6,21,37,37,37,37,37,36,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,53,6,21,37,37,37,37,37,36,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,38,54,22,21,35,35,35,35,35,35,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,23,39,55,22,21,35,35,35,35,35,35,0,0,0,0,0,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,6,21,35,35,35,35,35,35,0,0,0,0,0,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,6,21,37,37,37,37,37,36,0,0,0,0,0,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,22,21,37,37,37,37,37,36,0,0,0,0,0,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,35,22,21,35,35,35,35,35,35,0,0,0,0,0,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,6,21,35,35,35,35,35,35,0,0,0,0,0,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,6,21,35,35,35,35,35,35,0,0,0,0,0,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,37,22,21,37,37,37,37,37,36,0,0,0,0,0,")
grid=split("█゜⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘⁘ミWテhx⁘⁘⁘¹⁘⁘ˇしふ¹¹⌂あちU⁘⁘⁘ˇしふ¹¹¹⌂あちU⁘iyミテ⁘¹⁘●∧¹¹¹¹¹¹つめU⁘●∧¹¹¹¹¹¹¹つめ>ムムムムム¹⁘♥¹¹¹¹¹¹¹¹もT>♥¹¹¹¹¹¹¹¹¹も>⁘ミWWテ¹⁘☉¹¹¹¹¹¹¹¹やT>☉¹¹¹¹¹¹¹¹¹や◀‖t‖⁘⁘¹⁘¹¹¹¹¹¹¹¹¹NT>¹¹¹¹¹¹¹¹¹¹¹⁶‖u‖⁘⁘¹⁘¹¹¹¹¹¹¹¹¹NT>¹¹¹¹¹¹¹¹¹¹¹⁶‖t‖hx¹⁘¹¹¹¹¹¹¹¹¹NT>¹¹¹¹¹¹¹¹¹¹¹◀‖u‖iy¹⁘¹¹¹¹¹¹¹¹¹NT>¹¹¹¹¹¹¹¹¹¹¹⁶‖t‖ミテ¹⁘¹¹¹¹¹¹¹¹¹NT>¹¹¹¹¹¹¹¹¹¹¹⁶‖u‖⁘⁘¹⁘█¹¹¹¹¹¹¹¹NT>¹¹¹¹¹¹¹¹¹¹4◀‖t‖hx¹⁘▒¹¹¹NTT>ムムムム¹¹¹¹¹¹¹¹¹¹5⁶‖u‖iy¹⁘🐱★¹¹¹¹⌂あちU⁘⁘¹¹¹¹¹¹¹¹¹&6⁶‖t‖⁘⁘¹⁘⁘⧗こは¹¹¹¹つめU⁘¹¹¹¹¹¹¹⁷▶'7◀‖u‖⁘⁘¹⁘⁘⁘⁘⁘⁘¹¹¹¹もT>¹¹¹¹¹¹◀‖%%%%%%$⁘⁘¹¹¹¹¹¹¹¹¹¹¹やT>¹¹¹¹¹¹⁶‖dt‖t⁘⁘⁘⁘⁘¹¹¹¹¹¹¹¹¹¹¹NT>¹¹¹¹¹¹⁶‖eu‖u⁘⁘⁘⁘⁘¹¹¹¹¹¹¹¹¹¹¹NT>¹¹¹¹¹¹◀‖%%$⁘⁘⁘⁘⁘¹¹¹¹¹¹¹¹¹¹¹¹NT>¹¹¹¹¹¹◀‖⁘dt⁘⁘⁘⁘⁘¹¹¹¹¹¹¹¹¹¹¹¹NT>¹¹¹¹¹¹⁶‖⁘eu⁘⁘⁘⁘⁘¹¹¹¹¹¹¹¹¹¹¹¹NT>¹¹¹¹¹¹⁶‖⁘⁘⁘⁘⁘⁘⁘⁘¹¹¹¹¹¹¹¹¹¹¹¹NT>¹¹¹¹¹¹◀‖ムムムムムムムム¹¹¹¹¹¹¹¹¹¹¹¹NT>¹¹¹¹¹¹¹¹NT>⁘⁘⁘⁘⁘¹¹¹¹¹¹¹¹¹¹¹¹NT>¹¹¹¹¹¹¹¹NT>⁘⁘⁘⁘⁘¹¹¹¹¹¹¹¹¹¹¹¹NT>¹¹¹¹¹¹¹¹NT>⁘⁘⁘⁘⁘¹¹¹¹¹¹¹¹¹¹¹¹pT>█¹¹¹¹¹¹¹NT>⁘⁘⁘⁘⁘¹¹¹¹¹¹¹¹¹¹¹¹qT>▒¹¹¹¹¹¹¹NT>⁘⁘⁘⁘⁘¹¹¹¹¹¹¹¹¹¹¹brV⁘🐱★¹¹¹¹¹¹NT>⁘⁘⁘⁘⁘¹¹¹¹¹¹¹¹¹CScV⁘⁘⁘⧗¹¹¹¹¹¹NT>⁘⁘⁘⁘⁘¹¹¹¹¹¹¹¹NT>⁘⁘hx¹¹¹¹¹¹GちUミWテ¹¹¹¹¹¹¹Nメ^ョュャT>ミテiy¹¹¹¹¹¹¹つめU⁘⁘¹¹¹¹¹¹¹Nメ^ョュャT>dtdt¹¹¹¹¹¹¹¹もT>⁘¹¹¹¹¹¹¹Nメ^ョュャT>eueu¹¹¹¹¹¹¹¹やT>⁘¹¹¹¹¹¹¹Nメ^ョュャT>ミテ⁘⁘¹¹¹¹¹¹¹¹NT>⁘¹¹¹¹¹¹¹Nメ^ョュャTdtdt⁘¹¹¹¹¹¹¹¹NT>⁘¹¹¹¹¹¹¹Nメ^ョュャTeueu⁘¹¹¹¹¹¹¹¹NT>⁘¹¹¹¹¹¹¹¹¹¹¹¹NT>ムムムム¹¹¹¹¹¹¹¹¹◀dt¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹◀‖$¹¹¹¹¹¹¹¹¹¹⁶¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹⁶‖$¹¹¹¹¹¹¹¹¹¹T¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹⁶‖$¹¹¹¹¹¹¹¹¹¹T¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹◀‖$¹¹¹¹¹¹¹¹¹¹T¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹⁶‖$¹¹¹¹¹¹¹¹¹¹⁶¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹⁶eu¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹⁶%$¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹◀‖‖¹¹¹¹¹¹⁘█¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹pT>⁘¹¹¹¹¹¹⁘▒¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹qT>⁘¹¹¹¹¹¹⁘🐱★¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹brV⁘⁘¹¹¹¹¹¹⁘⁘⧗こは¹¹¹¹¹¹¹¹¹¹¹¹¹CScVミWテ¹¹¹¹¹¹⁘ムムムムム¹¹¹NT>⁘ミWテhx⁘ムムムムム⁘¹¹¹¹¹¹⁘⁘⁘⁘⁘⁘¹¹¹NT>⁘⁘⁘⁘iyミWWWテ⁘⁘¹¹¹¹¹¹##dt##3333◀‖dt####‖‖#####¹¹¹¹¹¹##eu##3333⁶‖eu####‖‖#####¹¹¹¹¹¹##33##3333⁶‖d$%$##‖‖##⁘⁘#¹¹¹¹¹¹##33##3333◀‖e$%$##‖‖##⁘⁘#¹¹¹¹¹¹##dt##3333◀‖$%%%%%$dt‖⁘⁘⁘¹¹¹¹¹¹##eu##3333⁶‖$%%%%%$eu‖⁘⁘⁘¹¹¹¹¹¹##33##3333⁶‖dt########⁘⁘⁘¹¹¹¹¹¹##33##3333◀‖eu########⁘⁘⁘¹¹¹¹¹¹⁘⁘ˇしふ¹333333¹¹¹¹¹¹¹⌂あちU⁘⁘¹¹¹¹¹¹⁘●∧¹¹¹333333¹¹¹¹¹¹¹¹¹つめ⁘⁘¹¹¹¹¹¹⁘♥¹¹¹¹3333⁶‖$%%$¹¹¹¹¹¹もU⁘⁘⁘⁘⁘⁘¹⁘☉¹¹¹¹3333◀‖$%%$¹¹¹¹¹¹やT⁘⁘⁘⁘⁘⁘¹⁘¹¹¹¹¹¹¹¹¹◀‖33¹¹¹¹¹¹¹¹¹T⁘⁘⁘⁘⁘⁘¹⁘¹¹¹¹¹¹¹¹¹⁶‖33¹¹¹¹¹¹¹¹¹T⁘⁘⁘⁘⁘⁘¹⁘¹¹¹¹¹¹¹¹¹⁶‖dt¹¹¹¹¹¹¹¹¹T⁘⁘⁘⁘⁘⁘¹⁘¹¹¹¹¹¹¹¹¹◀‖eu¹¹¹¹¹¹¹¹¹T⁘⁘⁘⁘⁘⁘¹⁘█¹¹¹¹¹¹¹4◀‖##¹¹¹¹¹¹¹¹¹T⁘⁘⁘⁘⁘⁘¹⁘▒¹¹¹¹¹¹¹5⁶‖##¹¹¹¹¹¹¹¹¹T⁘⁘⁘⁘⁘⁘¹⁘🐱★¹¹¹¹¹&6⁶‖##¹¹¹¹¹¹¹¹¹‖⁘⁘⁘⁘⁘⁘¹⁘⁘⧗こは¹⁷▶'7◀‖##¹¹¹¹¹¹¹¹¹‖⁘⁘⁘⁘⁘⁘¹◀‖####dt##3333¹¹¹¹¹¹¹¹¹‖⁘¹¹¹¹¹¹⁶‖####eu##3333¹¹¹¹¹¹¹¹¹‖⁘¹¹¹¹¹¹⁶‖####$%%%%%%%$¹¹¹¹¹¹¹4‖#¹¹¹¹¹¹◀‖####$%%%%%%%$¹¹¹¹¹¹¹5‖#¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹&6‖#¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹⁷▶'7‖#¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹◀‖##dt######¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹⁶‖##eu######¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹⁶‖##dt######¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹◀‖##eu######¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹◀‖dt####¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹⁶‖eu####¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹⁶‖dt####¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹◀‖eu####¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹◀‖######¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹⁶‖######¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹⁶‖######¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹◀‖######¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹EDDDDDDD¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹EDDDDDDD¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹EDDDDDDD¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹EDDDDDDD¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹EDDDDDDD¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹EDDDDDDD¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹EDDDDDDD¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹EDDDDDDD¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹EDDDDDDD¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹EDDDDDDD¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹EDDDDDDD¹¹¹¹¹¹¹¹¹¹¹◀‖$¹¹¹¹¹¹¹¹¹EDDDDDDD¹¹¹¹¹¹¹¹¹¹¹⁶‖$¹¹¹¹¹¹¹¹¹EDDDDDDD¹¹¹¹¹¹¹¹¹¹¹⁶‖$¹¹¹¹¹¹¹¹¹EDDDDDDD¹¹¹¹¹¹¹¹¹¹¹◀‖$¹¹¹¹¹¹¹¹¹EDDDDDDD¹¹¹¹¹¹¹¹¹¹¹◀‖$¹¹¹¹¹¹¹¹¹EDDDDDDD¹¹¹¹¹¹¹¹¹¹¹⁶‖#¹¹¹¹¹¹¹¹¹EDDDDDDD¹¹¹¹¹¹¹¹¹¹¹⁶‖#¹¹¹¹¹¹¹¹¹EDDDDDDD¹¹¹¹¹¹¹¹¹¹¹◀‖#¹¹¹¹¹¹¹¹¹EDDDDDDD¹¹¹¹¹¹¹¹◀‖$%‖$%%¹¹¹¹¹¹¹◀‖######¹¹¹¹¹¹¹¹⁶‖##‖###¹¹¹¹¹¹¹⁶‖%%%%%$¹¹¹¹¹¹¹¹⁶‖##‖###¹¹¹¹¹¹¹⁶‖%%%%%$¹¹¹¹¹¹¹¹◀‖$%‖$%%¹¹¹¹¹¹¹◀‖######¹¹¹¹¹¹¹¹◀‖dt‖dt‖¹¹¹¹¹¹¹◀‖######¹¹¹¹¹¹¹¹⁶‖eu‖eu‖¹¹¹¹¹¹¹⁶‖######¹¹¹¹¹¹¹¹⁶‖$%‖$%‖¹¹¹¹¹¹¹⁶‖%%%%%$¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹◀‖######¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹◀‖######¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹4⁶‖%%%%%$¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹5⁶‖%%%%%$¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹&6◀‖######¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹¹⁷▶'7◀‖######¹¹¹¹¹¹%%%%%%%%%%%%%%%%%⁶‖######¹¹¹¹¹¹%%%%%%%%%%%%%%%%%⁶‖%%%%%$¹¹¹¹¹¹#################◀‖%%%%%$¹¹¹¹¹¹#################◀‖######¹¹¹¹¹¹%%%%%%%%%%%%%%%%%⁶‖######¹¹¹¹¹¹%%%%%%%%%%%%%%%%%⁶‖######¹¹¹¹¹¹%%%%%%%%%%%%%%%%%◀‖%%%%%$¹¹¹¹¹¹","")

tilew=ord(grid[1])
tileh=ord(grid[2])
tilegrid={}
for i=0,tilew+2 do
 tilegrid[i]={}
 for j=0,tileh+2 do
  tilegrid[i][j]=0
 end
end
for i=0,tilew-1 do
 for j=0,tileh-1 do
  --tilegrid[i][j]=mget(i,j)
  tilegrid[i][j]=ord(grid[i*tileh+j+3])
 end
end
--mouse
poke(0x5f2d,1)

--tiletyp={}
--n=1
--for k,v in pairs(t_ang) do
-- if v==0 then
--	 tiletyp[n]=k
--	 n+=1
-- end
--end
--
----ramps
--add(tiletyp,138)
--add(tiletyp,67)
--add(tiletyp,181)
--add(tiletyp,179)
--add(tiletyp,7)
----non-solid
--add(tiletyp,51)
--add(tiletyp,253)
--add(tiletyp,252)
--add(tiletyp,251)
--add(tiletyp,78)
--add(tiletyp,94)
--
--ramp_seq=
--{
--[138]=
--{138,0,0,0,
--154,0,0,0,
--170,171,0,0,
--85,187,188,189},
--[67]=
--{0,0,0,67,
--0,0,0,83,
--0,0,98,99,
--112,113,114,86},
--[181]=
--{20,134,135,136,
--149,150,0,0,
--165,0,0,0,
--181,0,0,0},
--[179]=
--{128,129,130,20,
--0,0,146,147,
--0,0,0,163,
--0,0,0,179},
--[7]=
--{0,0,0,7,
--0,0,0,23,
--0,0,38,39,
--52,53,54,55}
--}

--function save_level()
-- local str=chr(tilew)..chr(tileh)
--	for i=0,tilew-1 do
--	 for j=0,tileh-1 do
--	  --str..=tilegrid[i][j]..","
--	  local s=tilegrid[i][j]
--	  s=s==0 and 1 or s
--	  str..=chr(s)
--	 end
--	end
--	printh(str,"@clip")
--end
-->8
--init
function _init()
 game=false
 gdt=0
end

function init_game()
 pre_dt=0
 opening=0
 dt=0
 tim=0
 
 music(7)
 
 --consts
 acc=0x.06
 air_acc=0x.0c
 dec=.25
 frc=0x.06
 slp=0x.1
 fal=1.25
 
 top=4
 
 jmp=3.25
 grv=0x.1c
 
 --vars
 sgs,swin,sdead=0,0
 sang=0
 v_sang=0
 sx=45
 sxs=0
 sy=--[[150--]]80
 sys=0
 set_mode(0)
 sground=false
 sflip=false
 sstate="walk"
 hlock=0
 s_anim="stand"
 s_anim_timer=0
 s_anim_frame=0
 spin_rev=0
 invinc=0
 
 rings=0
 
 --camera
 cx,cy=sx,sy
 
 --curr_shield=false--rnd(7)\1+1
 
 obj={}
 --rings
 init_obj(spl_unp"1,252,2")
 init_obj(spl_unp"1,264,2")
 init_obj(spl_unp"1,276,2")
 
 init_obj(spl_unp"1,132,140")
 init_obj(spl_unp"1,144,140")
 init_obj(spl_unp"1,156,140")
 
 --monitors
 init_obj(spl_unp"2,70,79,0")
 init_obj(spl_unp"2,64,183,1")
 
 --badnik
 init_obj(spl_unp"6,224,44")
 
 --spike
 init_obj(spl_unp"7,202,167")
 
 --end ring
 init_obj(spl_unp"8,995,-40")
 
-- init_obj(4,160,80,79)
 init_obj(spl_unp"4,700,80,79")
end
-->8
--init functs
function init_obj(t,x,y,s)
 return add(obj,
 {
 typ=t,
 x=x,
 y=y,
 dead=-1,
 dt=0,
 w=({10,10,10,20,0,12,12,16})[t],
 solid=({false,true,false,false,false,false,1,false})[t],
 eff=0,--bumper expand time
 subtyp=s,
 }
 )
end
-->8
--update
function _update60()
 gdt+=1
 
 if not game and gdt>60 and (btnp(❎) or btnp(🅾️)) then
  game=true
  init_game()
 end
 
 if game then
  upd_game()
 end
end

function upd_game()
 if (sdead and sdead>180) _init()
 if pre_dt<110 then
  pre_dt+=1
 else
  dt+=1
  if (swin>0) swin+=1
  if swin<=20 then
   _upd()
  end
 end
 
 --camera
 if not (sdead or swin>0) then
	 cx+=max(0,abs(sx-cx)-4)*sgn(sx-cx)
	 if not sground then
	  cy+=max(0,abs(sy-cy)-16)*sgn(sy-cy)
	 else
	  local camspd=max(3,abs(sgs))
	  cy+=mid(-camspd,camspd,sy-cy)
	 end
	 --cx=mid(64,cx,336)
	 --cx=mid(64,cx,336+336+288)
	 cx=mid(64,cx,tilew*8-56-8)
	 --cy=mid(-64,cy,136)
	 cy=mid(0,cy,tileh*8-56-56)
	-- sx=40
	-- sy=80
 end
end

function _upd()
 if (sdead) sdead+=1
 if (dt%60==0) tim+=1
	for i=-10,16 do
	 checked[i]={}
	end
	
	if spdshoes_dt then
		spdshoes_dt+=1
		if spdshoes_dt>1200 then
			mus_spd_nxt=13
		 acc,spdshoes_dt=0x.06
		 air_acc=0x.0c
		 top=4
	 end
 end
 
 if mus_spd_nxt and last_mus~=stat(24) then
		for i=33,61 do
		 poke(0x3200+68*i+65,mus_spd_nxt)
		end
	 music(stat(24))
	 mus_spd_nxt=nil
 end
 last_mus=stat(24)
	
	if (invinc>0 and sstate~="hurt") invinc-=1

 --slope
 if sground then
  sgs+=slp*sin(sang)
 end
 
 --input and ground spd upd
 
 if sstate~="spdash"
 and sstate~="crouch"
 and sstate~="hurt"
 then
	 if sground then
	  sgs=input_x(sgs,acc,dec,frc)
	 else
	  sxs=input_x(sxs,air_acc,air_acc,0)
	 end
 end
 
-- if band(btn(),3)==0 then
--  launch=false
-- end
 
 hlock=max(0,hlock-1)
 
 djump=djump and not sground
 --jump
 if sstate~="hurt" then
  grv=0x.1c
	 if (btnp(❎) or btnp(🅾️)) then
		 if sground then
		  if sstate=="walk" or sstate=="spin" then
     sfx(16)
			  jmp_press=true
			  sstate="spin"
			  sground=false
			  sxs+=jmp*sin(sang)
			  --sgs=sxs
			  sys-=jmp*cos(sang)
			  set_mode(0)
			  sang=0
		  end
		 elseif not djump then
		  djump=true
		  sstate="spin"
		  if curr_shield==1 then
		   sfx(11)
			  sxs=sflip and -3 or 3
			  sys=btn(⬆️) and -3 or 3
		  end
		 end
	 end
	 if jmp_press
	 and (not (btn(❎) or btn(🅾️))
	 or sys>-2)
	 then
	  jmp_press=false
	  sys=max(-2,sys)
	 end
	else
  grv=0x.18
 end
 
 if not sground then
  --sxs=sgs
  sys+=grv
  hlock=0
  --air drag
  if sys<0 and sys>-4 then
   sxs-=sxs\0x.2/256
  end
 else
	 sxs=sgs*cos(sang)
	 sys=sgs*sin(sang)
	 
	 --fall
  if abs(sgs)<fal
  and sang>0x.2
  and sang<0x.e
  and hlock==0
  then
	  if sang>=0x.4
	  and sang<=0x.c then
	   sground=false
    --sgs=sxs
    set_mode(0)
    sang=0
	  end
   hlock=30
  end
 end
 
 sys=mid(8,-8,sys)
 
 sx+=sxs
 sy+=sys
 
 if sx<5 or sx>tilew*8 then
  sx=mid(5,sx,tilew*8)
  sxs=0
  sgs=0
 end
 
 if not sdead then
	 --wall collision
	 if smode~=0 then
		 for i=-5,6,11 do
		  local hh,tile=gr_check(0,i-(smode==3 and 0 or 1),last,true)
		  if hh==8 then
		   sgs=0
		   set_mode(0)
		   sang=0
		  end
		 end
		end
	 if smode==0 then
		 for i=-5,6,11 do
		  local hh,tile=gr_check(0,i,last,true)
		  if hh==8 then
		   for pix=1,8 do
		    if t_height[tile][pix]==8 then
		     wall=pix
		     if (i>0) break
		    end
		   end
		   
		   sx=(flr(sx)+i)\8*8-i+wall-sgn(i)*.5-.5
		   sgs=0
		   sxs=0
		  end
		 end
	 end
	 
	 --"for loop" once in case of falling on a wall (detects floor 1st,switches mode and detects wall) 
	 for i=0,sground and 0 or 1 do
		 --ground collision/snap
		 if sground or sys>0 or abs(sxs)>abs(sys) then
		  grn_coll(1)
		 end
		 
		 --ceil collision/snap
		 if not sground and (sys<0 or abs(sxs)>abs(sys)) then
		  grn_coll(-1,true)
		 end
	 end
	 
	 --obj coll
	 for o in all(obj) do
	  if o.solid and o.dead<0
	  and (sstate~="spin" or o.solid==1) then
	   if abs(sx-o.x)<=o.w
	   and abs(sy-o.y)<=o.w then
	    sx=o.x-(o.w+.01)*sgn(sxs)
		   sgs=0
		   sxs=0
	   end
	   if abs(sx-o.x)<=o.w
	   and abs(sy+sgn(sys)*4-o.y)<=o.w then
	    sy=o.y-(o.w+sgn(sys)*4)*sgn(sys)
		   sys=0
		   sground=true
		   sgs=sxs
		   if (o.typ==7) s_hurt()
	   end
	  end
	 end
 end

 --obj
 for o in all(obj) do
  o.dt+=1
  --move
  if o.typ==3 then
   o.y-=.15
   o.x+=sin(o.dt/60)/5
   if o.dt>1200
   and o.dead<0 then
    o.dead=1
   end
  elseif o.typ==6 then
   o.x-=o.flip and -.3 or .3
   if dt%300==299 then
    o.flip=not o.flip
   end
  end
  --collision
	 if o.dead<0 then
   if sstate~="hurt"
   and abs(sx-o.x)<=o.w
   and abs(sy-o.y)<=o.w then
    if o.typ==1
    and invinc<90 then
     --ring
     sfx(21)
     rings+=1
     o.dead=1
    elseif o.typ==2
    and sstate=="spin" then
     --monitor
     sfx(17)
     sfx(18)
     if o.subtyp==1 then
      --speed shoes
						mus_spd_nxt=10
						spdshoes_dt=0
					 acc=0x.0c
					 air_acc=0x.18
					 top=6
					else
					 --shield
      curr_shield=1
     end
     sys*=-1
     jmp_press=true
     init_obj(5,o.x,o.y)
     --expl.dead=0
     o.dead=1
    elseif o.typ==3 then
     --bubble
     jmp_press=true
     sground=false
     sys=-3.5
     o.dead=1
     sfx(20)
    elseif o.typ==4 then
     --bumper
     local dx,dy=o.x-sx,o.y-sy
     if sqrt(dx^2+dy^2)<=20 then
	     sfx(28)
	     local ang=atan2(dx,dy)
	     sys=sin(ang+.275)*4
	     sxs=cos(ang+.275)*4
	     sx=o.x-cos(ang)*22
	     sy=o.y-sin(ang)*22
	     o.dt=-20
				  sstate="spin"
				  sground=false
			  end
    elseif o.typ==6 then
     if sstate=="spin" then
	     --badnik
	     sfx(17)
	     sfx(18)
	     sys*=-1*sgn(sys)
	     jmp_press=true
	     init_obj(5,o.x,o.y)
	     o.dead=40
	    else
	     s_hurt()
     end
    elseif o.typ==8 and swin==0 then
     --giant ring
     sfx(62)
     swin+=1
    end
   end
   --scattered rings
	  if o.scatter then
	   o.x+=o.xs
	   o.y+=o.ys
	   o.ys+=0x.0c
	   local tile=o.x>0 and o.x<tilew*8 and tilegrid[o.x\8][(o.y+4)\8]
	   local ang=tile and t_ang[tile]
	   if o.dt%4==o.scatter
	   and o.ys>0
	   and ang
	   and ang==0
	   then
	    o.ys=min(-1.5,o.ys*-.75)
	   end
	   if (o.dt>256) del(obj,o)
	  end
  else
   o.dead+=1
   if o.dead>=24 and o.typ~=2 then
    del(obj,o)
   end
	 end
 end
 
-- if dt==15 then
--  s_hurt()
-- end
 
 spin_rev-=spin_rev\0x.2/256
 if sstate~="hurt" then
	 if btn(⬇️) then
	  if abs(sgs)>=.5 or not sground or -abs(-sang+.5)+.5>0x.2 then
	   if sstate~="spin" then
	    sfx(9)
	   end
	   sstate="spin"
	  else
	   if sstate~="spdash" then
	    sstate="crouch"
	   end
	   sgs=0
	   sxs=0
	   if btnp(❎) or btnp(🅾️) then
	    if sstate=="spdash" then
	     spin_rev=min(4,spin_rev+1)
	    else
	     sstate="spdash"
	     spin_rev=0
	    end
	    for i=0,31 do
	     poke(0x35fc+2*i,min(117,i+105)+spin_rev*2\1)
	    end
	    sfx(15)
	   end
	  end
	 else
	  if sstate=="spdash" then
	   for i=0,3 do
	    if (stat(i+16)==15) sfx(-1,i)
	   end
	   sfx(10)
	   sfx(11)
	   sstate="spin"
	   sgs=(4+spin_rev)*(sflip and -1 or 1)
	  elseif sground
		 and (btn(⬆️)
		 or abs(sgs)<.25) then
			 sstate="walk"
		 end
	 end
 end
 
 if sground then
  v_sang=sang
 else
  ang=abs(v_sang*2-1)-1
  if ang==0 then
   v_sang=0
  else
   v_sang+=sgn(v_sang-.5)/64
  end
 end

 --acid sprite animation
 if dt%6==0 then
  local acid_t={}
  for j=0,3 do
	  for i=0,7 do
	   acid_t[i]=sget(40+i,32+j)
	  end
	  for i=0,7 do
	   sset(40+i,32+j,acid_t[(i-1)%8])
	  end
  end
 end
 if dt%30==0 then
	 for i=0,7 do
	  for j=0,3 do
	   sset(40+i,32+j,sget(40+i,32+j+1))
	  end
	 end
 elseif dt%30==15 then
	 for i=0,7 do
	  for j=4,1,-1 do
	   sset(40+i,32+j,sget(40+i,32+j-1))
	  end
	  sset(40+i,32,0)
	 end
 end
 
 if dt%230==0 then
  init_obj(3,736+(dt%460/6),142)
 end
 
 --mouse
-- mousex,mousey=stat(32),stat(33)
--	tgttilex,tgttiley=(mousex+cx-64)\8,(mousey+cy-64)\8
-- if stat(34)==1 then
--  if mousey<94 or not show_tilesel then
--   --increase w
--	  if tgttilex>=tilew then
--	   tilew+=1
--	   local i=tilew+2
--			 tilegrid[i]={}
--			 for j=0,tileh+2 do
--			  tilegrid[i][j]=0
--			 end
--	  end
--   --increase h
--	  if tgttiley>=tileh then
--	   tileh+=1
--				for i=0,tilew+2 do
--				 local j=tileh+2
--				 tilegrid[i][j]=0
--				end
--	  end
--	  --place tile
--	  tilegrid[tgttilex][tgttiley]=draw_typ or 0
--	  if ramp_seq[draw_typ] then
--	   for i=0,15 do
--	    tilegrid[tgttilex+i%4][tgttiley+i\4]=ramp_seq[draw_typ][i+1]
--	   end
--	  end
--	 else
--	  draw_typ=tiletyp[mousex\8+(mousey-94)\8*16+1]
--	 end
--	elseif stat(34)==2 then
--	 draw_typ=tilegrid[tgttilex][tgttiley]
-- end
-- if (btnp(⬆️)) show_tilesel=not show_tilesel
end
--menuitem(1,"save level",save_level)

-->8
--upd functs
function input_x(xs,acc,dec,frc)
 local cap,roll=mid(top,8,abs(xs))
 
-- local ⬅️,➡️=⬅️,➡️
-- if launch then
--  ⬅️,➡️=➡️,⬅️
-- end
 if sstate=="spin" and sground then
  roll=true
  frc/=2
  acc=-frc
  dec=dec/2+frc
 end
 if btn(⬅️) and (hlock==0 or not sground) then
  if xs<=0 then
   xs-=acc
  else
   xs-=dec
  end
  sflip=true
 elseif btn(➡️) and (hlock==0 or not sground) then
  if xs>=0 then
   xs+=acc
  else
   xs+=dec
  end
  sflip=false
 else
  if (abs(xs)<=frc) xs=0
  xs-=frc*(xs==0 and 0 or sgn(xs))
 end
 
 return mid(-cap,xs,cap)
end

function gr_check(v1,v2,last,ign_semi)
 local xx,yy=flr(sx)+cos(m_ang)*v2-sin(m_ang)*v1,flr(sy)+cos(m_ang)*v1-sin(m_ang)*v2
 local tile=tilegrid[xx\8][yy\8]

 if tile~=237 or not ign_semi then
	 if t_height[tile] or last then
	  local tn,nn=t_height,xx
	  if smode%2==1 then
	   tn,nn=t_width,yy
	  end
	  local h=tn[tile]==nil and 0 or tn[tile][flr((nn)%8)+1]
	  return h,tile
	 end
 end
 
 return 0,0
end

function set_mode(n)
 smode=n
 m_ang=smode/4
end

function s_hurt()
 if invinc<=0 then
  invinc=120
  sys=-2
  sxs=1
  sstate="hurt"
		sground=false
		set_mode(0)
		sang=0
		v_sang=0
		
		if curr_shield then
		 curr_shield=nil
		 sfx(25)
		elseif rings>0 then
	  sfx(13)
	  sfx(14)
			for i=0,min(rings-1,31) do
			 local ang=i/16-0x.08
			 local spd=i\16-2
			 local last=init_obj(1,sx,sy)
			 last.scatter=i%4
			 last.xs=spd*sin(ang)
			 last.ys=spd*cos(ang)
			end
			rings=0
		else
		 sdead=0
		 sfx(25)
		end
 end
end
-->8
function _draw()
 cls(1)
 if game then
  drw_game()
 else
  ?"    sonic 2.5 sage 2020\n\n\nthis version of the game\nfeatures a very small level\nto test basic mechanics.\n\na new version with a bigger\nlevel and more content will\nbe released in the following\nweeks.\n\n\n⬅️⬇️➡️ move\nz x jump\nhold ⬆️ to use shield upwards\n\n(has controller support too)\n\n                    -bonevolt",10,5,6
 end
end

function drw_game()
 if pre_dt>60 then
	 _draw_stage()
 end
	
	if tim<1 then
	 opening+=(pre_dt<60) and 1 or -1
	 if (pre_dt<60) cls(2)
		rectfill(0,-1,127,opening*8,3)
		
		rectfill(224-opening*8,85,128,127,13)
		
		for i=0,127 do
		 rectfill(-1,i,min(44,opening*8-256)+(i-3)%12-min(5,(i-3)%12)*2,i,2)
		 rectfill(-1,i,min(44,opening*8-256)+i%12-min(5,i%12)*2,i,8)
		end
	end
	
	if swin>120 then
	 rectfill(20,20,107,107,2)
	 rect(21,21,106,106,6)
	 ?"\n     the end...\n\n...of this demo\n\n\n\nthanks for playing!\n\n press enter/pause\n     to reset",27,30,7
	end
	
	pal((
	{
	9,1,140,
	13,12,6,7,
	8+(curr_shield==6 and 128 or 0),2,138,139,
	143,10,4,15,137,}),1)
end

function _draw_stage()
 cls(2)
 
 --clouds
 if (dt==1) pre_gfx()
 
 if cx<650 then
	 --copy cloud from data
	 memcpy(0x6000+64*19,0x4300,37*64)
	 --bg water
	 rectfill(0,56,127,127,3)
	 --horizon line
	 rectfill(0,56,127,56,7)
	 pal(2,3)
	 pal(7,5)
	 pal(6,5)
	-- for i=0,19 do
	--  sspr(0,i,128,1,sin((i+dt\6)/6),57+i)
	-- end
	-- for i=0,19 do
	--  memcpy(i*64,0x4300+64*55+i*64,64)
	-- end
	
	 --water reflection
	 for i=0,19 do
	  memcpy(0x5dc0,0,64)
	  memcpy(0,0x4300-i*128+38*64,64)
	  sspr(0,0,128,1,sin((i+dt\6)/6),57+i)
	  memcpy(0,0x5dc0,64)
	 end
	 
	 --hills
	 memcpy(0x6000+79*64,0x4300+37*64,19*64)
	 
	 --field paralax
	 rectfill(0,98,127,99,11)
	 for i=0,27 do
	  local n=(cx/(i\2*2-30))%128
	  memcpy(0x5dc0,0,64)
	  memcpy(0,0x4300+i*64+56*64,64)
	  sspr(0,0,128,1,n,100+i)
	  sspr(0,0,128,1,n-128,100+i)
	  memcpy(0,0x5dc0,64)
	 end
	 
	 pal()
	 
	 --horizon water glimmer
	 for i=0,17 do
	  spr(70,i*8-dt\12%2,57,1,1,dt\6%2==0)
	 end
	else
	 rectfill(0,0,127,15,9)
	 fillp(0xbebe)
	 rectfill(0,15,127,30,0x92)
	 fillp(0x5a5a)
	 rectfill(0,30,127,45,0x92)
	 fillp(0x8282)
	 rectfill(0,45,127,60,0x92)
	 fillp(0x5a5a)
	 rectfill(0,119,127,127,0x92)
	 fillp()
	 palt(0,false)
	 for j=0,10 do
	  for i=12,127,32 do
		  spr(207,i,j*8+88-i%60)
		  spr(i%64==12 and 207 or 223,i+8,j*8+88-i%60,1,1,1)
	  end
	 end
	end
 
 camera(cx-64,cy-64)
 palt(0,true)
 --bg
-- for j=72,64,-8 do
--	 for i=0,128,64-16 do
--	  spr(8,i,j,6,7)
--	 end
-- end
-- 

 --cave
 for i=14,41 do
  for j=13,21 do
   spr((j==13 or j==18 and i<22 or j==21) and 111 or 95,i<<3,j<<3,1,1,j>17,j>17)
  end
 end
 
 palt(0,false)
 for i=73,89 do
  for j=-20,22 do
   spr(127,i<<3,j<<3)
  end
 end
 pal()
 
 --rectfill(73<<3,-20<<3,90<<3,23<<3,0x92)
 
 --map(0,0,0,0,16*8,16*4,0)
 
 --tileset
 for i=cx\8-8,cx\8+8 do
  for j=cy\8-8,cy\8+8 do
		 local t=tilegrid[i][j]
		 if j>=0 then
    draw_tile(i*8,j*8,t,i,j)
   end
  end
 end
 pal()
 
 --flower
 function flower(x,y)
	 palt(0,false)
	 palt(2,true)
	 local st=({0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,0,0,2,2,0,0,2,0,2,0})[dt\6%36+1]
	 sspr(120,24,8,8,x*8+st/2-1,y*8-st-7,9-st,7+st)
	 spr(79,x*8,y*8,1,1)
	 --spr(63,32*8,5*8,1,2)
	 palt(2,false)
	 palt(0,true)
 end
 flower(40,8)
 flower(18,10)
 flower(21,10)
 
 --waterfalls back
 if cx<650 then
	 for i=1,4 do
	  pal(i,(-dt\8+i)%4+3)
	 end
	 for i=37,41 do
	  for j=6,12 do
	   spr(143,i*8,j*16+2,1,2)
	  end
	  spr(175,i*8,6.5*16-9)
	  spr(175,i*8,11.5*16-9)
	 end
	else
	 for i=1,4 do
	  pal(i,({2,11,10,13})[(-dt\8+i)%4+1])
	 end
	 for i=100,104 do
	  for j=4,8 do
	   spr(143,i*8,j*16+2,1,2)
	  end
	  spr(175,i*8,4.5*16-9)
	 end
	end
 
 pal()
 
 for o in all(obj) do
  if abs(cx-o.x)<64+o.w
  and abs(cy-o.y)<64+o.w then
	  if o.typ==1 then
    --rings
		  if o.dead<0 then
		   spr(dt\5%6,o.x-4,o.y-4)
		  end
		 elseif o.typ==2 then
		  --monitor
			 palt(0,false)
			 palt(15,true)
			 if o.dead<0 then
				 spr(224,o.x-7,o.y-7,2,2)
				 sspr(16,108+o.subtyp*5,7,5,o.x-3,o.y-2)
				 palt(0,true)
				 palt(15,false)
				 pal(dt%12>6 and {7,6,4} or {4,7,6})
				 if (dt%6<2) sspr(23,112,9,7,o.x-4,o.y-3)
			 else
				 spr(218,o.x-7,o.y+1,2,1)
				end
			 pal()
		 elseif o.typ==3 then
		  --bubble
		  if o.dead<0 or dt%4<2 then
		   spr(102,o.x-8,o.y-8,2,2)
		  end
		 elseif o.typ==4 then
		  --conveyor bumper
			 local cx,cy=camera()
			 camera(cx-o.x,cy-o.y)
			 circfill(0,0,21-min(o.dt\20,0),10+dt\4%2)
			 circfill(0,0,20,9)
			 circfill(0,-1,19,4)
			 for k=2,14 do
			  i=({0,1,2,3,4,5,6,7,14,13,12,11,10,9,8})[k+1]
			  circfill(cos(i/32)*17+.5,sin(i/32)*17+.5,2,({2,4,6,7})[-sin(i/32)*3\1+1])
			 end
			 for i=0,15,.5 do
			  circfill(sin(t()*1.5+i/16)*15+.5,cos(t()*1.5+i/16)*15+.5,2,({11,10,13,7})[i\1%4+1])
			 end
			 circfill(0,0,12,9)
			 circfill(0,-1,11,4)
			 circfill(0,-4,7,6)
			 circfill(0,-5,4,7)
			 camera(cx,cy)
		 elseif o.typ==5 then
				for i=1,5 do
				 local c=o.dt\2+i-3
				 pal(i,({7,6,4})[mid(1,3,c)])
				 if (c>5) palt(i,true)
				end
				spr(204,o.x-8,o.y-8-o.dt/8,2,2)
				pal()
		 elseif o.typ==6 then
			 palt(0,false)
			 palt(5,true)
			 if dt\2%2==0 then
			  palt(0,true)
			  palt(1,true)
			  palt(3,true)
			  palt(13,true)
			 end
			 pal(3,7)
			 spr(185,o.x-12,o.y-7,3,2,o.flip)
			 pal()
		 elseif o.typ==7 then
		  --spike
				spr(238,o.x-8,o.y-7,2,2)
		 elseif o.typ==8 and swin<40 then
			 --giant ring
			 --pal(s_clr[dt\90%7+1])
			 pal(s_clr[2])
			 if (swin>0) pal(s_clr[dt\2%7+1])
			 for l=0,3 do
				 for i=0,1,0x.08 do
				  local x,y=sin(i)*sin(t()/1.5)*14,cos(i)*14
				  local r=min(5-l,5-l*2+(l>0 and sin(i+(t()-sin(t()/.75)/16-.5)/-1.5+.125)*4+4 or 0)-l)
				  circfill(o.x+x+l-r/4,o.y+y-l/2,r,3-l+dt\1%2)
				 end
			 end
			 pal()
		 end
		end
 end
 
 --sonic
 if swin==0 or swin<20 and dt%2==0 then
	 palt(0,false)
	 palt(5,true)
	 palt(3,true)
	 palt(3,false)
	 --ashura
	-- pal(2,11)
	-- pal(3,2)
	 spr_w=12
	 function upd_anim(new_anim,max_dur,anim_frames)
	  local dur=flr(max(0,max_dur-abs(sgs*2)))
	  if new_anim~=s_anim then
	   s_anim_frame=0
	   s_anim=new_anim
	  else
	   if s_anim_timer>0 then
	    s_anim_timer-=1
	   else
	    s_anim_timer=dur
	    s_anim_frame=(s_anim_frame+1)%anim_frames
	   end
	  end
	  return s_anim_frame
	 end
	 
	 spr_h=19
	 if sstate=="spin" then
	  --spinning
	  spr_index=14
	  spr_w=8
	 elseif sstate=="hurt" then
	  spr_index=232
	  spr_h=15
	 else
		 if sgs==0 then
		  --standing
		  spr_index=64
		  spr_w=8
		  upd_anim("stand",1,1)
		 elseif abs(sgs)<3 then
		  --walking
		  spr_index=({[0]=128,131,134,137,140,176,179,182})[upd_anim("walk",8,8)]
		 else
		  --running
		  spr_index=({[0]=8,11,56,59})[upd_anim("run",10,4)]
		 end
	 end
	 
	 local spmem=spr_index%16*4+spr_index\16*8*64
	 
	 for j=0,19*64,64 do
	  --remove: cleans copied area
	  memset(0x200+j,0x55,12)
	  
	  if j<=spr_h*64 then
	   memcpy(0x200+j,spmem+j,spr_w)
	  end
	 end
	
	-- for i=0,2 do
	--  for j=0,2 do
	--   mset(16+i,j,spr_index+i+j*16)
	--  end
	-- end
	 
	 --if sground then
	 if invinc%8<4 then
		 if sstate=="spin" then
		  local spin_spr=upd_anim("spin",5,8)
		  if spin_spr%2==0 then
		   rspr(136,12,13,13,sx,sy,spin_spr*(sflip and 1 or -1)/8,sflip)
		  else
		   spr(107,sx-8,sy-7,2,2)
		  end
		 elseif sstate=="crouch" then
		  spr(230,sx-8,sy-8,2,2,sflip)
		 elseif sstate=="spdash" then
			 for i=8,15 do
			  pal(i,3)
			 end
			 if dt%2==0 then
			  pal(dt\2%5+11,4)
			  pal(8,4)
			  pal(1,6)
			  pal(6,3)
			 else
			  pal(1,4)
			  pal(4,3)
			  pal(6,4)
			  pal(9,4)
			 end
			 if dt%4<2 then
			  pal(8,2)
			 else
			  palt(8,true)
			 end
			 spr(109,sx-8,sy-8,2,2,sflip)
		  dash_dust(7)
		 else
		  spr_ang=(v_sang==mid(0x.18,v_sang,0x.e8) or (abs(sgs)>=1.5) or not sground) and flr(v_sang*32)/32 or 0
		  rspr(136,12,13,13,sx,sy,spr_ang,sflip)
		 end
	 end
	 local _,acid_tile=gr_check(8,0,1)
	 if acid_tile==69 then
	  if abs(sgs)>=3 then
	   dash_dust(10)
	  else
	   s_hurt()
	  end
	 end
 end
 pal()
 palt(0,true)
 
 --rings
 for o in all(obj) do
  if o.dead>=0 and o.typ==1 then
   spr(19,o.x-4,o.y-4,1,1,o.dead%12<6,o.dead%24<12)
  end
 end
 
 --waterfalls front
 if cx<650 then
	 for i=1,4 do
	  pal(i,(-dt\8+i)%4+4)
	 end
	 for i=37,41 do
	  for j=6,12 do
	   spr(143,i*8+1,j*16,1,2)
	  end
	  spr(175,i*8+1,6.5*16-8)
	  spr(175,i*8+1,11.5*16-8)
	 end
	else
	 for i=1,4 do
	  pal(i,({11,10,13,7})[(-dt\8+i)%4+1])
	 end
	 for i=100,104 do
	  for j=4,8 do
	   spr(143,i*8+1,j*16,1,2)
	  end
	  spr(175,i*8+1,4.5*16-8)
	 end
	end
 pal()
 
 --acid
 for i=cx\8-8,cx\8+8 do
  for j=cy\8-8,cy\8+8 do
   local t=tilegrid[i][j]
   if t==69 or t==68 then
    spr(t,i*8,j*8,1,1,f,v)
   end
  end
 end
 
 --map check
-- for i=0,16 do
--	 for j=0,16 do
--	  rect(
--	  i*8,j*8,
--	  i*8+7,j*8+7,
--	  checked[i][j])
--	 end
-- end
 
 --shield
-- if (dt%120==0) curr_shield=curr_shield%7+1
 if (swin==0 and curr_shield) draw_shield(curr_shield)
 
 --debug
 --[[
 --sonic center
 pset(sx,sy,8)
 
 --ground detectors
 for i=-4,4,8 do
  --⬇️
  pset(sx+i,sy+7,0)
  --➡️
  pset(sx+7,sy+i,0)
  --⬅️
  pset(sx-7,sy+i,0)
  --⬆️
  pset(sx+i,sy+-7,0)
 end
 
 --wall detectors
 for i=-5,5,10 do
  pset(sx+i,sy,0)
 end
 
 pset(sx,sy+17,7)
 
-- if (btn(⬅️)) print("⬅️",50,40,8)
-- if (btn(➡️)) print("➡️",60,40,8)
 
-- ]]
 cursor()
 camera()
 
-- line(40,10,40+cos(sang)*10,10+sin(sang)*10,8)
-- pset(40,10,7)
 color(7)
 outline(print,2,0,"time",6,3,13)
 outline(print,2,0,"rings",6,11,rings==0 and dt%16<8 and 8 or 13)
 outline(print,2,0,tim\60 ..":"..tim\10%6 ..tim%10,26,3,7)
 outline(print,2,0,rings,38,11,7)
 --[[
 ?"∧"..stat"1"
 ?"sxs "..sxs
 ?"sys "..sys
 ?"sgs "..sgs
 ?"hlock "..hlock
 ?"mode "..smode
 ?tt
 ?t2
--]]
-- cls(2)

--sspr(({[0]=0,24,48,72,96,0,24,48})[dt\4%8],({[0]=64,64,64,64,64,84,84,84})[dt\4%8],24,20,40,40)
--sspr(({[0]=72,96,72,96})[dt\4%4],({[0]=85,85,104,104})[dt\4%4],24,20,60,40)

	
--	?"∧"..stat(1),5,20,8
--	∧∧=∧∧ or 0
--	if (dt>1) ∧∧=max(stat(1),∧∧)
--	?"\n∧max "..∧∧
	--?sstate,5,20,8
--	?"\n"..tostr(sx)
--	?"\n"..tostr(sy)
--draw user memory
--memcpy(0x6000,0x4300,0x1b00)
-- c1=btn(⬅️) and 8 or 4
-- c2=btn(➡️) and 8 or 4
-- outline(print,2,0,"⬅️",55,110,c1)
-- outline(print,2,0,"➡️",65,110,c2) 
-- ?"\n"..tostr(btn(⬆️,1))

--mouse
--if show_tilesel then
--	rectfill(0,94,127,127,2)
--	for i=0,63 do
--	 draw_tile(i%16*8,95+i\16*8,tiletyp[i+1] or 0,0,0)
--	end
--end
--pal()
--if (ramp_seq[draw_typ]) rect(mousex,mousey,mousex+31,mousey+31,8)
--draw_tile(mousex,mousey,draw_typ or 0,0,0)
--pal()
--pset(mousex,mousey,8)
--	?"w:"..tilew,5,26,8
--	?"h:"..tileh,5,32,8
 
----values 0x10 and 0x30 to 0x3f change the efffect
--poke(0x5f5f,0x10)
----new colors on the affected line
----water
--pal({0x8d,1,0x81,0x8d,0x8c,0x86,0x87,0x88,0x81,3,0x83,0x86,0x8a,0x82,0x87,2},2)
----dark
--	 pal((
--		{
--		137,129,1,
--		141,13,13,6,
--		2,130,3,131,
--		142,138,132,143,
--		4}),2)
--waterlevel=64
--scr_wlevel=64-cy\1+waterlevel
--ll=0x5f70+scr_wlevel\8
--if scr_wlevel<0 then
-- scr_wlevel=0
-- ll=0x5f70
--end
--memset(0x5f70,0,15)
--memset(ll,0xff,min(15,0x5f7f-(ll)+1))
--if (scr_wlevel>0) poke(ll,255-(2^((scr_wlevel)%8)-1))
--water waves
--if dt%2==0 then
-- for i=0,127 do
--		 rectfill(i,scr_wlevel+1,i,scr_wlevel-2-sin(i/16+t())*sin(t())*1.1,7)
--	end
--end
--	?"∧"..stat(1),5,20,8
end
-->8
--draw functs
function rspr(sx,sy,sw,sh,dx,dy,a,f)
 f=f and -1 or 1
 a*=f
 a+=.25
 local sina8=sin(a)>>3 --equivalent to sin(a)/8, but faster
 local cosa8=cos(a)>>3
 sx>>=3 --since only used as sx/8 in loop, might as well change these variables as well
 sy>>=3
 for i=-sh,sh do
  tline(dx-sh*f,dy+i,dx+sh*f,dy+i,
   sw*sina8+i*cosa8+sx,
   sw*cosa8-i*sina8+sy,
   -sina8,-cosa8,1)
 end
end

function draw_shield(c)
 --dt=2
 --curr_shield=4
 local x,y=sx,sy
 if sground then
  x+=sin(spr_ang)*3
  y+=-cos(spr_ang)*3
 end
 if dt%2==0 then
	 for i=5,1,-1 do
	  circfill(x,y,sin(i/20)*-12,s_clr[c][max(i-2,(i-dt\2)%5)])
	 end
 end
 --circ(sx,sy,12,2)
end

function pre_gfx()
 cls(2)
 rectfill(40,50,120,60,6)
 outline(
 function()
  for i=0,20 do
   srand(10+i)
   circfill(i*4+40,(rnd(30)-2)*sin(i/40)+53,(rnd(10))*-sin(i/40)+3,7)
  end
 end,6,0)
 for i=0,36 do
--  --copy sheet to user data
--  memcpy(0x4300+i*64,i*64,64)
--  --copy screen to sheet
--  memcpy(i*64,0x6000+64*55-i*128,64)
  --copy screen to user data
  memcpy(0x4300+i*64,0x6000+64*19+i*64,64)
 end
 cls(3)
 --bg hills
 for h=0,1 do
	 for c=0,1 do
		 for i=0,127 do
		  rectfill(
		  i,84+h*10+c+sin((i-c*4+h*15)/60)*(3.5-c)+sin((i+h*15)/80)*(1.5),
		  i,127,c+10)
		 end
	 end
 end
 for i=0,18 do
  --copy screen to user data
  memcpy(0x4300+i*64+37*64,0x6000+64*79+i*64,64)
 end
 --field paralax
 for i=100,127 do
  for n=0,(i-95)*4 do
   pset((rnd()*127+cx/(i-130)/2)%128,i,rnd({1,10,13}))
  end
 end
 for i=0,27 do
  --copy screen to user data
  memcpy(0x4300+i*64+56*64,0x6000+64*100+i*64,64)
 end
end

function dash_dust(c)
 for i=0,15 do
  pal(i,c)
 end
 palt(0xffff)
 palt(({0b1011110111011111,0b1010110011001111,0b1010010001000111,0b1111110000000011,0b1111111111000000})[dt\2%5+1])
  spr(228,sx-8+(sflip and 12 or -12),sy-8,2,2,sflip)
end

function draw_tile(x,y,t,i,j)
 if t>1 then
	 pal()
	 local clr,f,v=(t==20 or t>=250) and (i+j)%2 or 0
	 pal(8,clr*14)
	 if clr==1 and (t>64 or t==20) then
	  pal(15,12)
	  pal(12,1)
	  pal(1,0)
	  pal(14,9)
	  pal(9,2)
	 end
	 if t>=128 and t<222 then
	  if t%16<5 then
	   v=1
	   t=128-16+t%16-((t-128)\16)*16
	  elseif t%16<10 then
	   t=128-16-(t%16-5)+4-1-((t-128)\16)*16
	   v,f=1,1
	  else
	   t=128-16-(t%16-10)+4-1+((t-128)\16)*16-64+16
	   f=1
	  end
	 elseif t==35 then
	  f=i%2==0
	  v=j%2==1
	  if f then
	   pal(6,2)
	  end
	  if v then
	   pal(2,7)
	   pal(7,2)
	   pal(3,2)
	  else
	   pal(3,6)
	  end
	 elseif t==36 then
	  v=j>13
	 end
	 if t~=69 and t~=68 then
	  spr(t,x,y,1,1,f,v)
	 end
	end
end
-->8
function grn_coll(o,ign_semi)
 --ground collision
 max_tile=0
 local higst_gr=-8
 for i=-4,4 do
  --normal
  g_ch,tile=gr_check(7*o,i,false,ign_semi)
	 --high
	 if g_ch==8 then
	  hi_ch,htile=gr_check(-1*o,i,true,ign_semi)
	  if (hi_ch>0) g_ch,tile=8+hi_ch,htile
	 --low
	 elseif g_ch==0 then
	  low_ch,ltile=gr_check(15*o,i,true,ign_semi)
	  g_ch,tile=-8+low_ch,ltile
	 end
	 --compare highest
	 if g_ch>higst_gr
	 or g_ch==higst_gr and hi_i and abs(i)<abs(hi_i) then
	  higst_gr,hi_i=g_ch,i
	  max_tile=tile
	 end
 end
 
 local function setgrnd(n)
  local sign=(smode\2*2-1)*o
  return (n-7*sign)\8*8+higst_gr*sign+3.5+3.5*sign
 end
 
 local xgrnd=setgrnd(sx)
 local ygrnd=setgrnd(sy)
 
 if t_height[max_tile] and
 sground
 and (t_ang[max_tile]==0
 or abs(t_ang[max_tile]-sang)<.15)
 or (sy*o>=ygrnd*o
 and (smode==0 or o==-1))
 then
  local landing=not sground
	 --adjust sx sy to ground
	 if smode%2==0 then
	  sy=ygrnd
	 else
	  sx=xgrnd
	 end
	 
	 if t_ang[max_tile]~=0
	 or o==1 then
		 local _,stand_ang=gr_check(8*o,hi_i,false,ign_semi)
		 sang=t_ang[stand_ang]==0 and m_ang or t_ang[stand_ang] or sang
		 set_mode(flr((sang+0x.2)*4)%4)
   
		 local steep=-abs(-sang+.5)+.5
	  if o==1 then
			 --landing on ground
			 if landing then
			  sgs=sxs
			  --shallow is ignored (sgs=sxs)
			  if steep>0x.1 then
			   if sys>=abs(sxs) then
				   --half/full steep with ys>=xs
				   if (steep<=0x.4) then
				    sgs=sys*((steep<=0x.2) and .5 or 1)*(sgn(sin(sang)))
				   end
			   end
--				  else
--				   launch=false
			  end
			 end
			 sground=true
		 else
			 --ceiling
	   if steep<=0x.6 then
	    if sys<-1.5 then
		    sgs=sys*(-sgn(-sin(sang)))
		    sground=true
		   else
		    sang=0
		    set_mode(0)
	    end
		  else
		   if abs(sxs)>=2 then
		    --launch=true
		    sgs=-sxs
		    sground=true
		   else
		    sang=0
		    set_mode(0)
		   end
	   end
 		end
  end
	 if landing then
   if sground then
	   sstate="walk"
	  end
	  sys=0
	 end
	elseif sground then
	 --launch
	 --launch=sang>0x.4 and sang<0x.c
	 sground=false
	 sxs=sgs*cos(sang)
	 set_mode(0)
	 sang=0
 end
end
-->8
--clouds
--by bonevolt

--draw functions
function pal_all(c)
 for n=0,15 do
  pal(n,c)
 end
end

function outline(draw,c,t,...)
 local o_pal,camx,camy={},camera()
 for i=0,15 do
  o_pal[i]=pal(i,c)
 end
-- o_pal=pal()
 --t:0 normal t:1 bold
 for i=-1,1 do
  for j=-1,1 do
   if abs(i^^j)==1 or t==1 then
    camera(camx+i,camy+j)
    draw(...)
   end
  end
 end
 camera(camx,camy)
 pal(o_pal)
 draw(...)
end

--function _draw()
-- camera()
-- dt=dt or 0
-- dt+=1
-- n=n or 31
-- --if (btnp(❎)) 
-- if (dt%3==0)n+=1
-- cls()
-- for i=0,10 do
--  srand(n+i)
--  outline(circfill,12,0,i*6+40,(rnd(10)-2)*sin(i/20)+50,(rnd(10))*-sin(i/20)+3,7)
-- end
--
-- camera(0,-40)
-- outline(
-- function()
--  for i=0,10 do
--   srand(n+i)
--   circfill(i*6+40,(rnd(10)-2)*sin(i/20)+50,(rnd(10))*-sin(i/20)+3,7)
--  end
-- end,12,0)
--
-- pal(0,1,1)
-- --?stat(1),0,20,7
--end
__gfx__
00777d0000777d0000077000000770000007700000777d0077777777000000075555555555555555555555555555555555555555555555555555555555555555
07ddddd0077dddd00077dd0000077000007d7d0007ddd7d066666666000000075555555555555555555555555555555555555555555555555555555555555555
7d0000dd07d00dd00077ed000007700000de7d000dd007d044444444000000075555553333335555555555555555555333333555555555555555555555555555
7d00007d07d007d00077ed000007d00000dedd000d1007d046444644000000075555222332233332555555555555522332233335255555555555555555555555
7d00007107d00710007de100000dd00000ded1000d10071042444244000000075555555232c33333255555555555552232c33333255555555555555555555555
1d00007e0dd0071000dde100000d100000ded1000d10071044444444000000075555555333334433355555555555555333334433355555555555553333555555
01d7771001dd7de0001dde000001e000001dde0001dd7de044444444000000765555533334367743455555555555553334367743455555555555333333335555
00e11e0000e11e000001e000000ee000000ee00000e11e0044444444000000765552233333377723255555555555533333377723255555555555523323333555
88858885888555555555555500d000d0fccccccf666666667777777700000076555552233337772725555555555522233337772725555555555333332c333355
8555858585855555555555550f7f0f7f8fccccf84444444466666666000000765555555333cff7772255555555555558888ff777225555555533333333346355
888588858855555555555555d777d0d0881111884744474444444444000000765555553cc3cfffffc5555555555588888888ffffc55555555333333333366655
5585855585855555555555550f7f000088111188464446444222222400000764555523077620ccc055555555555888888882ccc0555555555552333333366255
88858555858555555555555500d0000088111188464446444276672400000764558853067704488995555555558888882224455555555555555333333cc66225
5555555555555555555555550f000f0088111188424442444264462400000764584223334424e59995555555588882224434e55595555555553333223cc46455
555555555555555555555555d7d000008e9999e84444444442422424000076445844333333524949955555555888523333555555955555555535533222466458
5555555555555555555555550f000000e999999e22222222422222240000764458888555555449995555555558855542255555599555555555553333ec344585
55555555555555555555555537773377222222224677764200000000000764445488455555549999555555555885555255555599955555555523553344335885
55555555555555555555555564444444224442224677764200000000000764465546885555559999555555555585559445555999555555555555533394599855
55555555555555555555555564744444246664224677764200000000007644425558889955555995555555555558599994999999555555555555233399999555
55555555555555555555555564244444467776422222222200000000007644445555599999555555555555555555599949999955555555555555553399955555
55555555555555555555555564444444467776424677764200000000076444245555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555564444444422222424677764200000000764442645555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555564444444267776224677764200000007242426445555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555564744444467776424677764200000076624444445555555555555555555555555555555555555555555555555555555555555555
5555555555555555555555556000000400000000000000000000072644244444555555555555555555555555555555555555555555555555bbabbbab80222280
55555555555555555555555546000042000000000000000000007642422444445555555555555555555555555555555555555555555555552bbb2bbb88222288
55555555555555555555555504700420000000000000000000776424226422465555553333335555555555555555555333333555555555552bb22bb222888822
555555555555555555555555004742000000000000000000776644444442762455552223322333325555555555555223322333352555555592b222b228888082
5555555555555555555555550004700000000000000000776644442444267b625555555232c33333255555555555552232c3333325555555e922292928888882
555555555555555555555555004247000000000000077766444442644426bb425555555333334433355555555555555333334433355555558e222e9e28888882
55555555555555555555555504200460000000777776664446442644444264245555533334367743455555555555553334367743455555558e9299e829888892
5555555555555555555555554200004677777766666444444244444444642246555223333337772325555555555553333337772325555555e999999e22999922
5553333355555555000000000000000dbbbbbbbba0000aaa575565570000000055555223333777272555555555552223333777272555555500000000da2a2222
5233223333525555000000000000000abbbbbbbbaaaaaaaa05070065000000005555555333cff777225555555555555333cff7772255555500000000b6aa2222
55232c3333325555000000000000000abbbbbbbbbaaaabbb70006000000000005555553cc8888fffc55555555555883cc3cfffffc5555555000000002b6a2222
5553333443335555000000000000000abbbbbbbbbbbbbbbb006000000000000055552307762888805555555555582307762cccc05555555500000000222a2da6
5333636774345555000000000000000abbbbbbbbbbbbbbbb000000000000000055555306770448999555555555888306770445555555555500000000222aa6b2
3333337772325555000000000000000abbbbbbbbbbbbbbbb0000000000000000559223334434e99985555555588223334434e555955555550d00a00a222a2222
223333777272555500000000000000dbbbbbbbbbbbbbbbbb0000000000000000599445333353596885555555588852333355555595555555add0ad0a222a2222
55533cff7772255500000000000000abbbbbbbbbbbbbbbbb00000000aaad000059942225555537f895555555588555535555555995555555addabddb22d6b222
55223cfffffc555500000000000000dbbddbbddb2aabbaabbaabbaa288111188599995555555888655555555588555445555559995555555bbabbbab99eeee99
5222220ccc05555500000000000000dbbadbbadb9babbaabbaabbab9881111885599995555556889555555555585558645555999555555552bbb2bbb99eeee99
55555333e955555500000000000000dbbaabbaabe2abbaabbaabba2e881111885559999995555995555555555558588886888899555555552bb22bb2ee9999ee
55553c30cce555550000000000000ddbbaabbaab89abbaabbaabba988811118855555999999955555555555555555988688899555555555592b222b2ee9999ee
5552c330cc0555550000000000000ddbbaabbaab8eab2aabbaa2bae888111188555555555555555555555555555555555555555555555555e9222929ee9999ee
5555c72300455555000000000000adabbaabbaab88b222abba222b88881111885555555555555555555555555555555555555555555555558e222e9eee9999ee
5555776222455555000000000000adabbaabbaab8e2299bbbb9922e8881111885555555555555555555555555555555555555555555555558e9299e899eeee99
555566425255555500000000000dbaabbaabbaabe929992bb299929e88111188555555555555555555555555555555555555555555555555e999999e99eeee99
555555525255555500000000000abaab7777777777777776000000aaaaa00000fccccccccccccccf555555555555553333355555555555555555555522222222
55555566546555550000000000dabaab64444444444444490000aaaa0aaaa0008fccccccccccccf8555555555555333333333555555555555555555592929292
55555878929955550000000000dbbaab6474444444444742000aa0a0a0aaaa008811111111111188255555555553333333333355555555555555555529292929
5555568888929555000000000ddbbaab642444444444424200ba0a00000ddaa0881111111111118825555555552323333334433555555555223dd55599999999
555555555555555500000000addbbaab644444444444444200b0a00000d77da088111111111111883555555555223333334774355555552cccc966359e99999e
55555555555555550000000dbddbbaab67777777777777760bbb000000d77daa881111111111118845555555522233333347743355555233cc414695e99999e9
555555555555555500000d0abdabbaab66666666666666620bb00000000dd0aa8811111111111188255555555223233333344333555523333c171d9e99eeee99
5555555555555555000a0ddbbaabbaab64444444444444420a0b000000000a0a881111111111118825555555532233333333333355523bb33c4143ee99eeee99
0000000000000000000aaddb00000000e99dddd9999dddd90ab00000000000aa8811111111111188225555555322233333333333552223bb3cdd3eee29e92922
00000000000000000d0abadb0000000092dddd2222dddd220abb000000000aaa8811111111111188c55555555322323333333333552232333eeeeee5229e9222
00000000000000000ddbbaab000000009dddd2222dddd22200a0b0000000a0a0881111111111118855555555553223233333333552222333f333332529e92922
0000000000000d0daddbbaab00000000f11122221111222200ab0b00000b0ba0881111111111118855555555553222323232323552223233ff33f255229e9222
00000000000a0ddabddbbaab000000006444444444444442000ab0b0b0b0ba008811111111111188555555555553222223232355522223232f2f255529e92922
0000a000ad0aaddbbadbbaab0000000064444444444444420000aabb0bbbb000881111111111118855555555555533222222255552222222f2f25555229e9222
0a0aa0daaddabddbbaabbaab000000006444444444444442000000aabbb000008e999999999999e8555555555555553322255555552222222255555529e92922
aadabddabddbbddbbaabbaab0000000064444444444444420000000000000000e99999999999999e5555555555555555555555555552222255555555229e9222
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555530401010
55555333333555555555555555555333333555555555555555555333333555555555555555555333333555555555555555555333333555555555555540101010
55523333322335555555555555523333322335555555555555523333223332555555555555552332233335255555555555552332233335255555555540101010
5555223332c33355555555555555223332c3335555555555555552332c3333555555555555555232c33333255555555555555232c33333255555555540102010
55555233433343355555555555555233433343355555555555553333333443355555555555555333334433355555555555555333334433355555555540202020
55533334743674355555555555533334743674355555555555533336336774355555555555553334367743455555555555553334367743455555555510202020
55333333433677255555555555333333433677255555555555333333337772455555555555533333377723255555555555533333377723255555555510202020
52222333333677255555555552222333333677255555555555222333337772655555555555522333377727255555555555522333377727255555555510203020
5555323333cf7792555555555555323333cf779255555555555532333cff77225555555555555333cff772255555555555555333cff772255555555520303030
5553222333cfffc5555555555553222333cfffc555555555555322233cffffc55555555555553223cfffffc55555555555553223cfffffc55555555520303030
55522222230ccc775555555555522222230ccc55555555555552222220ccc055555555555555222220ccc0555555555555670c2220ccc0555555555520303030
555449333e95567755555555555555333e9c7755555555555555559e3e95555555555555555670c03e95466555555555557765c03e9555466555555520304030
555443334ce0046655555555555553334ce6775555555555555556773c05555555555555555776333cc9464555555555557645333cc999464555555530404040
55552323ec0555555555555555552323ec04665555555555555554673ce5555555555555555764233033544555555555555552323c0555544555555530404040
55555553309255989255555555555552309255555555555555555544233355555555555555555552332355555555555555555552333355588955555530404040
55984235555526692955555555598423555255555555555555555522946355555555555555594225594655555555555555994225555468789555555530401040
54f866555555494295555555554f8665555245555555555555555529884555555555555555994455588615555555555555986555555588695555555520302030
580f055555559929555555555986f055555448688855555555555542968555555555555555246655596888155555555555469555555599455555555530403040
98805555555592955555555559886555555999499255555555555999298955555555555555529985555988855555555559884555555522555555555540404040
98055555555555555555555559855555555299225555555555555299929855555555555555552298555555555555555559995555555555555555555510101040
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555510101010
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555520102010
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555520202020
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555520202020
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555333333555555555555555555333333555555555555555555333333555555555555555555564446444444100555555555555555555555555555555555555
55552332233335255555555555523333223332555555555555523333322335555555555595595426942766666433d05555555555555555555555555555555555
55555232c333332555555555555552332c333355555555555555223332c33355555555555955942494264444443d155555555555555555555555555555555555
55555333334433355555555555553333333443355555555555555233433343355555555555aaaab9296999999910555555555555555555555555555555555555
5555333436774345555555555553333633677435555555555553333474367435555555555a7aa7bb929922222229e92555555555555555555555555555555555
55533333377723255555555555333333337772455555555555333333433677255555555562aa227b999e999ee89e889255555555555555555555555555555555
55522333377727255555555555222333337772655555555552222333333677255555555562b7226b929e8288e9288e9255555555555555555555555555555555
55555333cff7722555555555555532333cff7722555555555555323333cf77925555555556bb664b92992429922e992200000000000000005555555529999999
55553223cfffffc555555555555322233cffffc5555555555553222333cfffc55555555559bbbbb9222622622252222500003111230000005555555599eee000
5555676220ccc055555555555552267720ccc05555555555555222233677cc555555555555999992554924955555555500031111123444005555555599999eee
555577403e95466555555555555554673e955555555555555555553e046755555555555555222525549252555555555500331111123333405555555599999eee
555546433cc9464555555555555555443ce445555555555555555333324455555555555555525555552555555555555502222333222113345555555529999999
555552323c0554455555555555555223ec0445555555555555552323ec0255555555555555555555555555555555555502231112223113345555555599eee000
55529422333355555555555555555553209455555555555555555553209225555555555555555555555555555555555533311112232123345555555599999eee
55549642255355555555555555555523552555555555555555555523594255555555555555555555555555555555555532311112233333445555555599999eee
55994955555687118955555555555539242555555555555555554235294495555555555555555555ffffffffffffffff33422222322234458811118822222222
52999455555886889555555555555446945555555555555555588445524999555555555555555555fff2fffff2fff22f44433233211124558811118822999eee
529955555559949555555555555559886155555555555555555988615552995555555555555555554f222fff222f262f04321123211123458811118822222999
55555555555225555555555555555286888155555555555555558688815555555555555555555555467226276222762f00321123211123408811118822222999
5555555555555555fffffff555555555555555555555555555555555555555555555555555555555246762464247642f00333333332333408811118822222222
5555555555555555fffffff555555555555555555555555555555555555555555555555555555555f2466644266642ff00433333433334508811118822999eee
5555555555555555fffffff555555555555555555555555555555555555555555555555555555555ffff2464422fffff00544444554455008e9999e822222999
5555555555555555fffffff555555555555555555555555555555555555555555555555555555555244667776766442f0000554550555000e999999e22222999
fffffffffffffffffffffff21122332255555555555555555555555555555555555555555555555555555555fccccccf291fee82bddbbddb0040000000400000
f6677777777766ff2677222122332211555555555555555555555555555555555555555555555555555555558fccccf8291fee82badbbadb0060004000600040
464444444444462f2464222233221133555555555555555555555555555555555555533333254455555555558811118828eef192baabbaab0060004000600040
469222222222962f298892231133221155e955555555555555555553355355555553333333336455555555558811118828eef192baabbaab0060004000600040
462d1111111d262f28888891332233225555e55555555555555555523353355555624236743446455555555588111188291fee82baabbaab0464004004640040
462128070821262f222222221133113355e5595555555555555533333333335552477c47773624255555555588111188291fee82baabbaab0474044404740444
462180777081262f99dd799322112211555955555555555555523333333333553677634772624259852555558811118828eef192baabbaab0474044404740444
462180777081262f9d99979000000000555555555555555555555233427333353266733772f22959922555558811118828eef192baabbaab0474044404740444
462180777081262f91999d90000000005555544555555555553333367643333755224c3cff99f2582929555518888881c111111cfccccccf0474044404740444
462128070821262f9199919000000000e5434343455555555323333c67723336553330c0ff8809582929555591888819ec1111ce8fccccf80676044406760444
462d1111111d262f99d1199000000000595444333355555555533ece77663334553223ec0cc095682222555599eeee99ee8888ee881111880676046406760464
464222222222462f23222320000000005558877333355555533233e9332ce32255255329c99e55742222555599eeee99ee8888ee881111884676446446764464
246777777777642f252235300000000055dccb777311555555522233664322255555522539cce5692929555599eeee99ee8888ee881111884676446446764464
f2466644466642ff5753232000000000599ccbbbb661155555556642222222555555525333ee3246992255559deeae9aee8888ee881111884676446446764464
ffff2466642fffff25223220000000005f9988bbbaa611555558789292225555555555535322555422255555add2ad2ae922229e8e9999e84676446446764464
244667777766442f23235320000000005555fff77aaa61155596888892955555555555552225555555555555addabddb92222229e999999e4676446646764466
__label__
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111aaa1aaa1aaa1aaa11111777111117771777111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111a111a11aaa1a1111111717117111171711111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111a111a11a1a1aa111111717111117771777111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111a111a11a1a1a1111111717117117111117111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111a11aaa1a1a1aaa11111777111117771777111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111188818881881118811881111111111111777111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111181811811818181118111111111111111717111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111188111811818181118881111111111111717111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111181811811818181811181111111111111717111111117711111111111111111111111111111111111111111111111111111111111111111111111111111
11111181818881818188818811111111111171777111111177aa1111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111111111111111111111111111771111111111774a1111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111111111111111111111111111774a11111111774a1111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111111111111111111111111117a49111111117a491111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111111111111111111111111111aa4911111111aa491111111111111111111111111166666111111111111111111111111111111111111111111111
1111111111111111111111111111111111119aa4111111119aa41111111111111111111111111677777611111111111111111111111111111111111111111111
11111111111111111111111111111111111119411111111119411111111111111111111111116777777761111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111166666111167777777776111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111116677777661677777777777611111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111667777777776777777777777761111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111116777777777777777777777777761111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111167777777777777777777777777761111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111167777777777777777777777777761111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111677777777777777777777777777761111111111111111111111111111111111111111
111111111111111a11q11q1a11q11q1a11q11q1a11q11q1a11q11q1a11q67q777777777777777777777777611111111111111111111111111111111111111111
11111111111111qaa1qa1qqaa1qa1qqaa1qa1qqaa1qa1qqaa1qa1qqaa1qa7q777777777777777777777776661111111111111111111111111111111111111111
11111111111111qaaqraarqaaqraarqaaqraarqaaqraarqaaqraarqaaqraar777777777777777777777777776611111111111111111111111111111111111111
11111111111111raarraarraarraarraarraarraarraarraarraarraarraar777777777777777777777777777766111111111111111111111111111111111111
11111111111111rqarrqarrqarrqarrqarrqarrqarrqarrqarrqarrqarrqar777777777777777777777777777777611666111166666111111111111111111111
11111111111111rqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqr777777777777777777777777777777766777666677777661111111111111111111
11111111111111rqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqr777777777777777777777777777777777777777777777776111111111111111111
11111111111111rqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqr777777777777777777777777777777777777777777777777611111111111111111
11111111111111rqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqr777777777777777777777777777777777777777777777777761111111111111111
11111111111111rqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqr777777777777777777777777777777777777777777777777761111111111111111
11111111111111rqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqr777777777777777777777777777777777777777777777777776111111111111111
11111111111111rrqrrrqrrrqrrrqrrrqrrrqrrrqrrrqrrrqrrrqrrrqrrrqr777777777777777777777777777777777777777777777777776111111111111111
111111111111111rrr1rrr1rrr1rrr1rrr1rrr1rrr1rrr1rrr1rrr1rrr1rrr777777777777777777777777777777777777777777777777776111111111111111
111111111111111rr11rr11rr11rr11rr11rr11rr11rr11rr11rr11rr11rr1777777777777777777777777777777777777777777777777776111111111111111
1111111111111121r111r121r111r121r111r121r111r121r111r121r111r1777777777777777777777777777777777777777777777777776111111111111111
11111111111111421112124211121242111212421112124211121242111212777777777777777777777777777777777777777777777777761111111111111111
11111111111111p4111424p4111424p4111424p4111424p4111424p4111424777777777777777777777777777777777777777777777777761116661111111111
11111111111111p421224pp421224pp421224pp421224pp421224pp421224p777777777777777777777777777777777777777777777777666667776611111111
11111111111111422222244222222442222224422222244222222442222224777777777777777777777777777777777777777777777777777777777761111111
11111111111111fvvvvvvfv999999vfvvvvvvfv999999vfvvvvvvfv999999v767777777777777777777777777777777777777777777777777777777761111111
11111111111111pfvvvvfp4v9999v4pfvvvvfp4v9999v4pfvvvvfp4v9999v4777777777777777777777777777777777777777766677777777777777776111111
11111111111111pp9999pp44pppp44pp9999pp44pppp44pp9999pp44pppp44777777777777777777777777777777777777766666677777777777777777611111
11111111111111pp9999pp44pppp44pp9999pp44pppp44pp9999pp44pppp44777777777777777777777777777777777777666666667777777777777777761111
11111111111111pp9999pp44pppp44pp9999pp44pppp44pp9999pp44pppp447sssss777777777777777777777777777776666666666777777777777777776111
11111111111111pp9999pp44pppp44pp9999pp44pppp44pp9999pp44pppp41ss11ssss6166666777777777777777777766666666666666677777777777776111
11111111111111p422224p42111124p422224p42111124p422224p421111241s1vsssss166666667777777777777777666666666666666666667777777776111
111111111111114222222421111112422222242111111242222224211111127ssssddsss66666666677777777776666666666666666666666666667777761111
777777777777779pppppp9v999999v9pppppp9v999999v9pppppp9v999999sss6s677dsd77777777777777777777777777777777777777777777777777777777
c7cc6cc7c7cc6c29pppp924v9999v429pppp924v9999v429pppp924v9999ssssss7771s1c7cc6cc7c7cc6cc7c7cc6cc7c7cc6cc7c7cc6cc7c7cc6cc7c7cc6cc7
scs7ss6cscs7ss2244442244pppp442244442244pppp442244442244pppp11ssss777171ccc7cc6cccc7cc6cccc7cc6cccc7cc6cccc7cc6cccc7cc6cccc7ss6c
7sss6sss7sss6s2244442244pppp442244442244pppp442244442244pppp44cssvff77711ccc6ccc7ccc6ccc7ccc6ccc7ccc6ccc7ccc6ccc7ccc6ccc7ccc6sss
ss6sssssss6sss2244442244pppp442244442244pppp442244442244pppp4411svfffffvcc6ccccccc6ccccccc6ccccccc6ccccccc6ccccccc6ccccccc6sssss
ssssssssssssss2244442244pppp442244442244pppp442244442244pppp411111pvvvpcccccccccccccccccccccccccccccccccccccccccccccccccccssssss
ssssssssssssss211111124211112421111112421111242111111242111124cccsss42cccccccccccccccccccccccccccccccccccccccccccccccccccsssssss
ssssssssssssss111111112111111211111111211111121111111121111112ccsvspvv4cccccccccccccccccccccccccccccccccccccccccssscccssssssssss
ssssssssssssss9pppppp9p444444p9pppppp9p444444p9pppppp9p444444pc1vsspvvpccccccccccccccccccccccccccccccccccccccccccsssssssssssssss
ssssssssssssss29pppp921p4444p129pppp921p4444p129pppp921p4444p1ccv71sppdcccccccccccccccccccccccccccccccccccccccccssssssssssssssss
ssssssssssssss224444221122221122444422112222112244442211222211cc776111dcccccccccccccccccccccccccccccccccccccccccssssssssssssssss
ssssssssssssss224444221122221122444422112222112244442211222211cc66d1c1ccccccccccccccccccccccccccccccccccccccccccssssssssssssssss
ssssssssssssss224444221122221122444422112222112244442211222211ccccc1c1ccccccccccccccccccccccccccccccccccccccccssssssssssssssssss
sssssssassqssq2a44q42q1a22q21q2a44q42q1a22q21q2a44q42q1a22q21qcacc66cd6ccccccccccccccccccccccsscccsssscccccsssssssssssssssssssss
ssssssqaasqasqqaa1qa1qqaa1qa1qqaa1qa1qqaa1qa1qqaa1qa1qqaa1qa1qqaa8782122ccccccccccccccccccssssssssssssssssssssssssssssssssssssss
ssssssqaaqraarqaaqraarqaaqraarqaaqraarqaaqraarqaaqraarqaaqraarqaa68888212cccccccccccccssssssssssssssssssssssssssssssssssssssssss
sssssaraarraarraarraarraarraarraarraarraarraarraarraarraarraarraarraarcccccccccccccccccsssssssssssssssssssssssssssssssssssssssss
sssssqrqarrqarrqarrqarrqarrqarrqarrqarrqarrqarrqarrqarrqarrqarrqarrqarccccccccccccccccccsssss8psssss8pssssssssssssssssssssssssss
sssssqrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrcccscccccccccccccssssss88sssss88ssssssssssssssssssssssssss
sssssqrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrsssssscccccccccssssssssss88888ssssssssssssssssssssssssssss
sssssqrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrsssssssscccccsssssssssss88888p8sssssssssssssssssssssssssss
sssssqrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrssssssssssssssssssssssss8888888sssssssssssssssssssssssssss
ssssarrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrssssssssssssssssssssssss2888882sssssssssssssssssssssssssss
ssssqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrrqqrsssssssssssssssssssssssss22222ssssssssssssssssssssssssssss
ssssarrrqrrrqrrrqrrrqrrrqrrrqrrrqrrrqrrrqrrrqr7777777777777776rrqrrrqrssssssqqqqqsssssssssssssaqsqssssssssssssssssssssssssssssss
ssssar1rrr1rrr1rrr1rrr1rrr1rrr1rrr1rrr1rrr1rrr6dddddddddddddd21rrr1rrrsqqqqqqqqqqqqqqqqsssssssr6qqssssssssssssssssssssssssssssss
sssqar1rr11rr11rr11rr11rr11rr11rr11rr11rr11rr16d7dddddddddd7d11rr11rr1qqqqqqqrrrrrrrrrrrrrrssssr6qsssssssssssssssssssssssssssqqq
sqqaar21r111r121r111r121r111r121r111r121r111r16d1dddddddddd1d121r111r1qqqrrrrrrrrrrrrrrrrrrrrrrrsqsaq6sssssssssssssssssssqqqqqqq
qqqaar42111212421112124211121242111212421112126dddddddddddddd142111212rrrrrrrrrrrrrrrrrrrrrrrrrrrqq6rsssssssssssssssqqqqqqqqqqqq
qrqaqrp4111424p4111424p4111424p4111424p41114246777777777777776p4111424rrrrrrrrrrrrrrrrrrrrrrrrrrrqrrrrrrrrssssqqqqqqqqqqqrrrrrrr
rrqaqrp421224pp421224pp421224pp421224pp421224p6666666666666661p421224prrrrrrrrrrrrrrrrrrrrrrrrrrrqrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
rarqqr42222224422222244222222442222224422222246dddddddddddddd142222224rrrrrrrrrrrrrrrrrrrrrrrrrra6rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
rqrqqrfvvvvvvffvvvvvvf7777777777777776fvvvvvvf422aaaa2222aaaa2129f44p17777777777777777777777777777777777777777rrrrrrrrrrrrrrrrrr
aqrqqrpfvvvvfppfvvvvfp6dddddddddddddd2pfvvvvfp21aaaa1111aaaa11129f44p16666666666666666666666666666666666666666rrrrrrrrrrrrrrrrrr
arrqqrpp9999pppp9999pp6d7dddddddddd7d1pp9999pp2aaaa1111aaaa1111p44f921ddddddddddddddddddddddddddddddddddddddddrrrrrrrrrrrrrrrrrr
arrqqrpp9999pppp9999pp6d1dddddddddd1d1pp9999ppf9991111999911111p44f921d111111dd6ddd6ddd6ddd6ddd111111dd6ddd6ddrrrrrrqqqqqqrrrrrr
arrqqrpp9999pppp9999pp6dddddddddddddd1pp9999pp6dddddddddddddd1129f44p1d176671dd1ddd1ddd1ddd1ddd176671dd1ddd1ddqqqqqqqqqqqqqqqqqq
arrqqrpp9999pppp9999pp6777777777777776pp9999pp6dddddddddddddd1129f44p1d16dd61dddddddddddddddddd16dd61dddddddddqqqqqqqqqqqqqrrqqq
qrrqqrp422224ppp9999pp6666666666666661pp9999pp6dddddddddddddd11p44f921d1d11d1dddddddddddddddddd1d11d1dddddddddqqqrrrrrrrrrrrrrrr
qrrqqr42222224pp9999pp6dddddddddddddd1pp9999pp6dddddddddddddd11p44f921d111111dddddddddddddddddd111111dddddddddrrrrrrrrrrrrrrrrrr
qrrqq1v999999vpp9999pp422aaaa2222aaaa2pp9999pp7777777777777776129f44p16666666666666666666666666666666666666666rrrrrrrrrrrrrrrrrr
qrrqr24v9999v4pp9999pp21aaaa1111aaaa11pp9999pp6dddddddddddddd2129f44p1ddddddddddddddddddddddddddddddddddddddddrrrrrrrrrrrrrrrrrr
qrrq1444pppp44pp9999pp2aaaa1111aaaa111pp9999pp6d7dddddddddd7d11p44f921d7ddd7ddd7ddd7ddd7ddd7ddd7ddd7ddd7ddd7ddrrrrrrrrrrrrrrrrrr
qrrq2p44pppp44pp9999ppf999111199991111pp9999pp6d1dddddddddd1d11p44f921d6ddd6ddd6ddd6ddd6ddd6ddd6ddd6ddd6ddd6ddrrrrrrrrrrrrrrrrrr
q1rq4p44pppp44pp9999pp6dddddddddddddd1pp9999pp6dddddddddddddd1129f44p1d6ddd6ddd6ddd6ddd6ddd6ddd6ddd6ddd6ddd6ddrrrrrrrrrrr9rrrrrr
111rpp44pppp44pp9999pp6dddddddddddddd1pp9999pp6777777777777776129f44p1d1ddd1ddd1ddd1ddd1ddd1ddd1ddd1ddd1ddd1ddrarrrrrrrrrrrrrrrr
22114p42111124p422224p6dddddddddddddd1p422224p66666666666666611p44f921ddddddddddddddddddddddddddddddddddddddddrrrqrrrr9rrrq9rrrr
22212421111112422222246dddddddddddddd1422222246dddddddddddddd11p44f921111111111111111111111111111111111111111199rarr9qrrrrrrrrrq
99999vfvvvvvvvvvvvvvvf7777777777777776fvvvvvvf422aaaa2222aaaa2129f44p11111111111111111111111111111111111111111rrrqrrrrrrqrrrrrrr
9999v4pfvvvvvvvvvvvvfp6dddddddddddddd2pfvvvvfp21aaaa1111aaaa11129f44p111ddd11111ddd11111ddd11111ddd11111ddd111arrrrrrrqarrqrrraa
pppp44pp999999999999pp6d7dddddddddd7d1pp9999pp2aaaa1111aaaa1111p44f9211d666d111d666d111d666d111d666d111d666d11rrrrrqrr9rrarrrarr
pppp44pp999999999999pp6d1dddddddddd1d1pp9999ppf9991111999911111p44f921d67776d1d67776d1d67776d1d67776d1d67776d1rrrrr9rqra9rrrrrr9
pppp44pp999999999999pp6dddddddddddddd1pp9999pp6dddddddddddddd1129f44p1d67776d1d67776d1d67776d1d67776d1d67776d1qarrarrr9rr9rrrr9q
pppp44pp999999999999pp6777777777777776pp9999pp6dddddddddddddd1129f44p1d11111d1d11111d1d11111d1d11111d1d11111d1rrrr9rarrrr9rararq
111124pp999999999999pp6666666666666661p422224p6dddddddddddddd11p44f9211677761116777611167776111677761116777611rrqrrrrrr9ar9rrrrr
111112pp999999999999pp6dddddddddddddd1422222246dddddddddddddd11p44f921d6c7d6c1d6c7d6c1d6c7d6c1d6c7d6c1d6c7d6c1rqrrrarrrra99rrqrr
vvvvvfpp999999999999pp422aaaa2222aaaa2v999999vfvvvvvvfv999999v129f44p1cc66cc66cc66cc66cc66cc66cc66cc66cc66cc66qrarrarrqraqar9rrr
vvvvfppp999999999999pp21aaaa1111aaaa114v9999v4pfvvvvfp4v9999v4129f44p16667666766676667666766676667666766676667qaqrrrrrar9a9rrq9r
9999pppp999999999999pp2aaaa1111aaaa11144pppp44pp9999pp44pppp441p44f921s7s7s767s7s7s767s7s7s767s7s7s767s7s7s767rrar99rar9rrrqra9r
9999pppp999999999999ppf99911119999111144pppp44pp9999pp44pppp441p44f921sdsdsds7sdsdsds7sdsdsds7sdsdsds7sdsdsds7rr99rrarar9aaqarrr
9999pppp999999999999pp6dddddddddddddd144pppp44pp9999pp44pppp44129f44p1ddsdddsdddsdddsdddsdddsdddsdddsdddsdddsdrraaqrrarrarrrqqr9
9999pppp999999999999pp6dddddddddddddd144pppp44pp9999pp44pppp44129f44p1dcdddcdddcdddcdddcdddcdddcdddcdddcdddcddrqqqrraq9rrr9rrar9
22224pp42222222222224p6dddddddddddddd142111124p422224p421111241p44f921dcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcqrqrqrrarrrr999a9a
22222442222222222222246dddddddddddddd12111111242222224211111121p44f921scdcdcdcscdcdcdcscdcdcdcscdcdcdcscdcdcdcrarraq99qqarqrrrrr
99999v1111111111111111111111111111111111111111111111111111111111111111scd6d6d6scd6d6d6scd6d6d6scd6d6d6scd6d6d6r9r9rrarq9rr9rrqra
9999v42121212121212121212121212121212121212121212121212121212121212121scd6c6d6scd6c6d6scd6c6d6scd6c6d6scd6c6d6q99rrq99arrqrqa9rr
pppp441212121212121212121212121212121212121212121212121212121212121212dcc6c6c6dcc6c6c6dcc6c6c6dcc6c6c6dcc6c6c69qarrarrrrrrrrqqaa
pppp442222222222222222222222222222222222222222222222222222222222222222dcc6c7c6dcc6c7c6dcc6c7c6dcc6c7c6dcc6c7c6qrra9ar9qrrarrqrqq
pppp442422222424222224242222242422222424222224242222242422222424222224d6c7c7c7d6c7c7c7d6c7c7c7d6c7c7c7d6c7c7c7a9q9rqaarr9qqrrqqa
pppp444222224242222242422222424222224242222242422222424222224242222242d6c767c7d6c767c7d6c767c7d6c767c7d6c767c7rqrr9rar9rqaaararr
1111242244442222444422224444222244442222444422224444222244442222444422c6676767c6676767c6676767c6676767c6676767rrr9q9a99qar9aaqaq
1111122244442222444422224444222244442222444422224444222244442222444422c6676d67c6676d67c6676d67c6676d67c6676d67raq99r999rqrrrqrr9

__gff__
00000000000000000101010101010000010101000000000001010101010100000101010000000000010101010101000001010100000000000101010101010001010101000000000001010101010101010101010000000000010101010101000101010000000000000000010000a1a10100000000000000000000010000010101
0101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100010101a1a1a101a1a101010100010000000101010101b001010101010000000000
__map__
1414141414141414141414141414140010111200000000000000000000000000000000000000000000000000001414141414142323232323232323141414141414141414141414160606160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000025252323252525
1414868788000000000080818214140020212200000000000000000000000000000000000000000000000000008081821414142323232323232323148687880000000080818214151515150000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000025252323252525
1495960000000000000000009293140030313200000000000000000000000000000000000000000000000000000000929314146465333364653333959600000000000000009293232323230000000000000000000000000000000000000000000000000000000000000000001606061616060600000000000025252323252525
14a50000000000000000000000a314000000000000000000000000000000000000000000000000000000000000000000a314147475333374753333a500000000000000000000a3232323230000000000000000000000000000000000000000000000000000000000000000001515151515151500000000000025252323252525
14b50000000000000000000000b314000000000000000000000000000000000000000000000000000000000000000000b314142323232323232323b500000000000000000000b3232323230000000000000000000000000000000000000000000000000000000000000000002423232464652400000000000025252323252525
1400000000000000000000000000140000000000000000000000000000000000000000000000000000000000000000000014142323232323232323000000000000000000000000232323230000000000000000000000000000000000000000000000000016060616160606162523232574752500000000000025252323252525
1400000000000000000000540000000000000000000000000000000000000000000000000000000000000000000000000000003333333333333333333333330000000000000007646524240000000000000000000000000000000000000000000000000015151515151515151515151515151500000000000025252323252525
148a000000000000000000148a00000000000000000000000000000043545454545454545400000000000000000000000000003333333333333333333333330000000000000017747525250000000000000000000000000000000000000000000000000024242424242323232423232464652400000000000025252323252525
149a000000000000000000149a00000000000000000000000000000053141414141464651400000000000000000000000000003333333333333333333333330000000000002627232325250000000000000000000000000000000000000000000000000000000000000000002523232574752500000000000025252323252525
14aaab0000eeef0000000014aaab000000000000000000000000006263141464651474751416060616060000000000000000003333333333333333333333330000000034353637232325250000000000000000000000000000000000000000000000000000000000000000002523232515151500000000000025252323252525
1455bbbcbdfeff000000001455bbbcbd00000000000000000070717256141474751464651415151515150000000000000054541606061616060616333306161606061616060616333325250000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000025252323252525
1414145554545454545454141414555454545454545454545454561414141464651474751424242424240000000000000014141515151515151515333315151515151515151515333325250000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000025252323252525
1414141414141414141414141414141414141414141414141414141414141474751414141400000000000000000000000014146465646524246465000024243333646523232323333325250000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000025252323252525
1414868788000000000000000000000000000000000000000080818214000000000000000000000000000000000000000014147475242425257475000025253333747523232323333325250000160606160000000000000000000000000000000000000000000000000000000000000000000000000000000725252323252525
1495960000000000000000000000000000000000000000000000009293000000000000000000000000000000000000000014142323252525252323000025250000000000000000000024240000151515150000000000000000000000000000000000000000000000000000000000000000000000000000001725252323252525
14a5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000014142323242425252323000024240000000000000000000000000000232323230000000000000000000000000000000000000000000000000000000000000000000000000000262725252323252525
14b5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000014142323232325252323000000000000000000000000000000000000232323230000000000000000000000000000000000000000000000000000000000000000000000003435363725252323252525
1400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000014142323232325252323000000000000000000000000000000000000646564651606061616060616454545454545454545454545454545454545451606061616060616160606161606061616060616
1400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004314141515151524242323000000000000000000000000000000000000747574751515151515151515444444444444444444444444444444444444441515151515151515151515151515151515151515
14000000000000000000000000001606061616060616000000000000004700000000000000000000000000000000000053141415151515646523238a0000000000000000000000000000000007232323236465646523232323444444444444444444444444444444444444442325252323232523232525232323252523232325
148a00000000000000000000000715151515151515150000eeef000000aaab0000eeef0000000000000000000000006263141423232323747523239a0000000000000000000000000000000017232323237475747523232323444444444444444444444444444444444444442325252323232523232525232323252523232325
149a00000000000000000000001725646525141414140000feff00000055bbbcbdfeff000000000000000000007071725614142323232315152323aaab00000000000000000000000000002627232323232323232323232323444444444444444444444444444444444444442325252323232523232525232323252523232325
14aaab000000eeef00000000262725747525646514145454545454545414145554545454160654545406060616545614141414232314141414141455bbbcbd0000000000000000000034353637232323232323232323232323444444444444444444444444444444444444442325252323232523232525232323252523232325
1455bbbcbd00feff000034353637251515247475141414141414141414141414141414146400000000006525151414141414142323141414141414141455545454545454541515151515151515232323232323232323232323444444444444444444444444444444444444442325252323232523232525232323252523232325
1414145516060616060616060616247475141414141414141414141414141414141414147400000000007524151414141414142323232314141414141414141414141414141414141423232323232323232323232323232323444444444444444444444444444444444444442324242323232423232424232323242423232324
__sfx__
00020d1a0047000470002700027000260002600026000260002600026000260002600020000260002600026000260002600026000260002600026000260002600026000200002000020000200002000020000200
0101000824230242302423024230242302423024230242300c2000c2000c2000c2000c2000c2000c2000c2000c2000c2000c2000c2000c2000c2000c2000c2000c2000c2000c2000c2000c2000c2000c2000c200
010200103067030670306703067030670306703067030670306703067030670306703067030670306703067000000000000000000000000000000000000000000000000000000000000000000000000000000000
01010208303402b340243402434024340243402434024340000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000d00003800300000000000c203000000000000000000003b70037700347000c2033770034700307002d7000c2031840300000134031840300000184030000018403000000c2030000013403184031340300000
000d0000008000180022800248002480024800248002480024800248002480024800248002b800288002480021800218002d8052d80521800218002d8052d80522800228002e8052e80522800228002e8052e805
000d00003900029200292002b2002b2002b2002b2002b2002b2002b2002b2002b2002b2002b2002b2002b20028200282002820028200282002820028200282002920029200292002920029200292002920029200
000d00003700026400262002840028400284002840028400284002840028400284002840028400284002840024400244002440024400244002440024400244002640026400264002640026400264002640026400
000400002437024360243502137021360213502135021350213402134021330213302132021320213100c3020c3020c3000c3000c3000c3000c3000c3000c3000c3000c3000c3000c3000c3000c3000c3000c300
010a00003192032931339413493135931369313793137921379213792137920379103791037910379103720037200372003720037200372003720037200372000020000200002000020000200002000020000200
010200003e6353f6553f6653f6553e6553b655396553764535645316452d6452a645296452664523645216351e6351c6351a63519625166251462512615106150d61509615076150c6050c60500a0500a0500a05
00020000386353665534675316652d6552925525655222551f6551d2451b645192451864517245166451524514645132451264511245106450f2450e6450d2450d6450d2350d6350d2350d6350d2350d6250d215
010400003905037050390503704039040370403904037040390403704039030370303903037030390303703039030370303903037030390203701039010370000000000000000000000000000000000000000000
010400003975039755397503974539740397453974039745397403974539730397353973039735397303973539730397353973039730397203971039710397103971039710397100070000700007000070000700
010400003775537750377553774037745377403774537740377453774037735377303773537730377353773037735377303773037730377203771037710377103771037710377100070000700007000070000700
01040000299512a9512b9512c9512d9512e9512f95130951319513295133951349513595135951359513595135941359413594135941359313593135931359313592135921359213592135911359113591135911
000200001d0501d0511d0511d0511d0512205122051230512305124051240512505125051260512705128051290512a0512b0412c0412d0412e0312f031310213202134011000000000000000000000000000000
000100002165121651216512165123041240412504126031270212701128011280112801128011270112601125011240112301121011200111f0111d0111b0111a01118011160111401111011100111101114011
0002000021651216512165123021260212701128011280112701125011220111f0111c01118011140111001110011140100070000000000000000000000000000000000000000000000000000000000000000000
010400000a0500a0510b0610b0610b0710b0710b0610b0610b0520b0520b0420b0420b0320b0320b0220b01200000000000000000000000000000000000000000000000000000000000000000000000000000000
00020000052500645032640296400f2501d0700d2502106010250230500d230240300722024000102002400000000000000000000000000000000000000000000000000000000000000000000000000000000000
0103000034330373303c3203c3203c3103c3103c3103c310003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
010200002e3502e3502e3502c3502e3502c35000300003002e3502c3502e3502c3502e3502c3502e3502c3502e3502c3502e3502c3502e3502c3502e3502c3502e3502c3502e3402c3402e3302c3300030000000
010200000b2710b275176700d47510471124711326115261162611825118251182411824118230182301822018220182201822018220184121841218412184121840218402184021840018400184001840018400
010300000b2510b2510b2610d26110471124711346115461161611815118151181411814118130181301812018120181101811018100181000000000000000000000000000000000000000000000000000000000
000400000b1700b1700b1700b15000250002600027000270002700027000270002700027000270002700027000260002600026000260002500025000250002500024000240002400024000230002300023000230
0102000034a153ba153fa153fa153ea103ba1039a1037a1035a1031a102da102aa1029a1026a1023a1021a101ea101ca101aa1019a1016a1014a1012a1010a100ca1009a1006a1004a1002a1000a1000a1000a10
000200003e6353f6553f6653f6553e6553b655396553764535645316452d6452a645296452664523645216351e6351c6351a63519625166251462512615106150d6150961507615006050060500a0500a0500a05
000200000527116671052711667111266102661127610276112761027611276102661126610256112561025611256102561125610256112461023611226102161120610206112061020611206102061120610206
01040000299302a9412b9512c9512d9512e9512f95130951319513295133950349503595035950359513594135940359313593135921359203592135911359113591035911359113591135910359113591135911
010300000000034b3034b3037b3037b303cb203cb203cb203cb203cb103cb103cb103cb103cb003cb003cb0000b0000b0000b0000b0000b0000b0000b0000b000000000000000000000000000000000000000000
0101000028b3028b3028b3028b3028b3028b302bb302bb302bb3030b3030b3030b3030b3030b3030b3030b3030b2030b2030b2030b2030b2030b2030b2030b2030b2030b1030b1030b1030b1030b1030b1030b10
010200000b2510b2550b2650b6651e6650f2751127112271132611526116261172611825118251182411824118241182301823018230182201822018220182201822018220184121841218412184121841218412
010d000024420214101d3102142024310213101d4202141024310214201d3102131024420214101d3102142026310233101f4202341026310234201f3102331026420234101f3102342026310233101f42023310
010d0020132430000030615306152b645000001324330615306151324330615306152b645000003061530615132430000030615306152b645000000c2330c233132430000030615306152b645000002b64500000
010d00001d8401d8001d8401d8401d8401d8001d8401d8401d8401d8001d8401d8401e8401e8001e8401e8401f8401f8001f8401f8401f8401f8001f8401f8401f8401f8001f8401f84020840208002084020840
010d00001d3201d32018320183201d3201d32018320183201d3201d32018320183201f3202032121321213201f3201f3201a3201a3201f3201f3201a3201a3201f3201f3201a3201a32021320223212332123320
010d00001c2301c230002001c2001c200002001c2301c2301c2301c2301c2301c2301c2300020000200002001a2301a230002001a2001a200002001a2301a2301a2301a230002000020015230152301523015230
010d0000218302180021830218302583025830218302480021830000002183021830268302683021830000001f830000001f8301f83026830268301f8301f8301e830000001e8301e83026830268301e8301e830
010d0000214202142021400214002140021400204202042020420204202042020420204202042020420204201f4201f420004001f4001f400004001e4201e4201e4201e42000400004001a4201a4201a4201a420
010d000017320173201732017320173201732017320173201730017300173001730019330193301a3301a33019330193301733017330153301533017330173301733017330173301733000000000000000000000
010d00001c830000001c8301c83020830208301c8301c8301c830000001c8301c83021830218301c8301c8301c8301c83023830238301c8301c8301c8301c83024830248301c8301c83023830238301c8301c830
010d00001c4201c4201c4201c4201c4201c4201c4201c4201c4001c4001c4001c4002512225112261222611225122251122312223112211222111223122231222312223122231122311200000000000000000000
010d00001432014320143201432014320143201532015320153201532015320153201032010320103201032018320183201832018320183201832017320173201732017320173201732014320143201432014320
010d00001c4101c4101c4101c4101c4101c4101c4101c4101c4001c4001c4201c4101f4201f4101c4201c41024120181101f110131201c1101011023120171101f110131201c1101011020120141101c12010110
010d0000132430000030615306152b645000001324330615306151324330615306152b645000003061530615132430000030615306152b645000000c2330c2332b6450000013243306152b6452b6051324313243
010d00000000000000000001c3201c320002001c2001c200002001c3101c3101c3101c3101c3101c3101c3100020000200002001a3201a320002001a3001a300002001a3101a3101a3101a310002000020015310
010d000015310153101531017310173101731017310173101731017310173101730017300173001730019310193101a3101a31019310193101731017310153101531017310173101731017310173101731000000
010d00001531015310153101431014310143101431014310143101531015310153101531015310153101031010310103101031018310183101831018310183101831017310173101731017310173101731014310
010d0000132430000030615306152b645000001324330615306151324330615306152b645000003061530615132430000030615306152b645000000c2330c233132430000030615306152b6452b6452b6452b645
010d00001e830000001e8301e8301e830000001e8301e8301e830000001e8301e8301e83000000238302383021830000001e8301e8301e830000001e8301e8301e830000001e8301e8301e830000001c8301d830
010d000000000000001c2401c240000000000000000000001e2401e240000000000019240192401c2401c24000000000001c2401c2402124021240000000000020240202401c2401c24000000000001c2401c240
010d000000000000001c2401c240000000000000000000001e2401e240000000000019240192401c2401c2400000000000214201e42021420214201e4200000021420000001e4200000023420234212442125420
010d0000253201e310213101e320253101e310213201e310253201e310213001e300253001e300213201e310233101c320203101c310233201c310203101c320233101c300203001c300233001c300203001c300
010d000000000000001c2401c240000000000000000000001e2401e240000000000019240192401c2401c2400000000000214201e42021420214201e4200000021420000001e420000001c4201c4201d4201d420
010d00001e840000001c840288401c840000001c840288401c840000001c840288401e840000001c840288401c840000001c840288401c840000001c8402884019840000001b8401b8401c840000001d8401d840
010d00001e4201e4201c4201c42000400004001c4201c420004000040019420194201e4201e4201c4201c42000400004001c4201c420004000040019420194202042020420214202142020420204201c4201c420
010d00001e4201e4201c4201c42000400004001c4201c420004000040019420194201e4201e4201c4201c42000400004001c4201c420004000040019400194002040020400214002140020400204001c4001c400
010d0000212202121020220202100020000200202202021000200002001c2201c210212202121020220202100020000200202202021000200002001c2201c2102322023210252202521023220232102022020210
010d00001e840000001c840288401c840000001c840288401c840000001c840288401e840000001c840288401c840000001c8401c8401c840000001c8401c8401f840000001f8401f84020840000002084020840
000d0000132430000030615306152b645000001324330615306151324330615306152b645000003061530615132430000030615306152b645000000c2330c2332b6352b6352b6352b6352b6452b6452b6452b645
010d0000252202521023220232100020000200232202321000200002001c2201c2102522025210232202321000200002002322023210002000020000200002000020000200002000020000200002000020000200
000200003864015370154701535015470153501547015350306402c450204702c450204702c450204702c450204602c440204602c440204502c430204502c430204412c431204412142120411214112041121411
001000001a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 0d0e4344
00 09194344
00 4a1c5b44
00 5c1d1944
00 411a4344
00 155e5f44
00 17204344
00 21222324
01 25262722
00 28292a22
00 25262722
00 2b292c2d
00 2e262225
00 2f292228
00 2e262225
00 3029312b
00 48323322
00 48323422
00 35323322
00 35323631
00 48373822
00 6637392d
00 3837313a
02 393b3c3d

