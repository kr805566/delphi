select * from room --房間檔
select * from sale --主檔, 住房
select * from fare --副檔, 消費
select * from farepay --副檔, 付款


update fare set FAPRICE=1000 where FANO=0
select FANO from fare where sano=0
select sano from room where rmno=''

select * from item --基本檔
select * from fare --交易檔