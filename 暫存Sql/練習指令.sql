SELECT TOP 50	FADATE,
				FATIME,
				COUNT(FAAMOUNT) AS QTY,
				SUM(FAAMOUNT) FAAMOUNT
FROM FARE
JOIN SALE ON FARE.SANO = SALE.SANO
	AND FARE.CPNO = SALE.CPNO
WHERE SALE.SAARRDATE >= '104/01/01'
AND FATIME >= '12:00:00'
GROUP BY	FADATE,
			FATIME
HAVING SUM(FAAMOUNT) > 0
ORDER BY FADATE ASC, FATIME DESC


