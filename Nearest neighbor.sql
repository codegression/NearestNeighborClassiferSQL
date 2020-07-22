DROP FUNCTION IF EXISTS EuclideanDistance;
DELIMITER $$
CREATE FUNCTION EuclideanDistance
(
	X1 DOUBLE, 
	X2 DOUBLE, 
	X3 DOUBLE,
	X4 DOUBLE,
	Y1 DOUBLE,
	Y2 DOUBLE, 
	Y3 DOUBLE, 
	Y4 DOUBLE
)	
RETURNS DOUBLE
DETERMINISTIC
BEGIN	
	RETURN SQRT
	(
		(X1-Y1) * 
		(X1-Y1)+
		(X2-Y2) *
		(X2-Y2)+
		(X3-Y3) * 
		(X3-Y3)+
		(X4-Y4) * 
		(X4-Y4)
	);
END
$$
DELIMITER ;

CREATE TEMPORARY TABLE Temp
SELECT *
FROM
(
	SELECT 
		test.id,
		test.f1,
		test.f2,
		test.f3,
		test.f4,
		train.class AS Prediction,
		EuclideanDistance
		(
			train.f1,
			train.f2,
			train.f3,
			train.f4,
			test.f1,
			test.f2,
			test.f3,
			test.f4
		) AS Distance
	FROM
		testset AS test,trainingset AS train 
) as T ORDER BY id, Distance;

SELECT *
FROM
Temp GROUP BY id;