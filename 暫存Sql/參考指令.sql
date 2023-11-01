select  *  from fare where (fadate ='102/08/16' or (fadate ='102/08/24' and fatime='15:53:40')) 
select itno, count( FAAMOUNT) as qty, sum(FAAMOUNT) FAAMOUNT  from fare  group by itno ORDER BY itno 

select FANO, FARE.CPNO, SANO, FADATE, FATIME, RMNO, FARE.ITNO, item.ITNAME,  FAPRICE  from fare
join item on FARE.ITNO = ITEM.ITNO
where FARE.ITNO='Z06'

select  * from fare

delete fare where ITNO='z06'
select * from  fare where ITNO='z06' --選擇性
backup database H001 to disk='d:\H001.bak' with init --必備

select isnull(UPDNAME,1)+'AA' from fare where (UPDNAME =aaa or UPDNAME is mull) and  date

select * from fare ORDER By itno desc

select itno, count( FAAMOUNT) as qty, sum(FAAMOUNT) FAAMOUNT  from fare  group by itno ORDER BY itno 