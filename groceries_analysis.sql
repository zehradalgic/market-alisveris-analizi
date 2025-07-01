-- 1)Tablo genelinde toplam kay�t say�s� ve her s�tundaki dolu/bo� (NULL) de�erlerin say�s�
SELECT
  COUNT(*) AS toplam_kayit,
  COUNT(member_number) AS member_number_dolu,
  COUNT(date) AS date_dolu,
  COUNT(itemdescription) AS itemdescription_dolu,
  
  COUNT(*) - COUNT(member_number) AS member_number_null_sayisi,
  COUNT(*) - COUNT(date) AS date_null_sayisi,
  COUNT(*) - COUNT(itemdescription) AS itemdescription_null_sayisi
FROM Groceries_dataset;
go


-- 2) Her m��terinin yapt��� al��veri�lerde ortalama ka� �r�n sat�n ald��� sorgusu
SELECT AVG(urun_sayisi) AS ortalama_urun_sayisi
FROM (
  SELECT member_number, COUNT(*) AS urun_sayisi
  FROM groceries_dataset
  GROUP BY member_number
) AS alt_sorgu;
go

-- 3) En �ok sat�lan ilk 10 �r�n�n listesi
SELECT TOP 10 itemdescription, COUNT(*) AS satis_adedi
FROM groceries_dataset
GROUP BY itemdescription
ORDER BY satis_adedi DESC;
go

-- 4) Ayn� al��veri�te en �ok beraber sat�n al�nan �r�n �iftlerinin listesi (ilk 10)
SELECT TOP 10 g1.itemdescription AS urun1, g2.itemdescription AS urun2, COUNT(*) AS beraber_satis_sayisi
FROM groceries_dataset g1
JOIN groceries_dataset g2
  ON g1.member_number = g2.member_number AND g1.itemdescription < g2.itemdescription
GROUP BY g1.itemdescription, g2.itemdescription
ORDER BY beraber_satis_sayisi DESC;
go

--5)Belirli bir m��terinin (member_number = 4501) t�m al��veri� kay�tlar�n� listeleme
select * from groceries_dataset where member_number=4501
go

--6) Y�llara ve aylara g�re toplam sat�� say�s�n�n da��l�m�
SELECT YEAR(date) AS yil, MONTH(date) AS ay, COUNT(*) AS toplam_satis
FROM groceries_dataset
GROUP BY YEAR(date), MONTH(date)
ORDER BY yil, ay;
go

--7) Mevsimlere g�re toplam sat�� say�lar�n�n analizi
SELECT
  CASE 
    WHEN MONTH(date) IN (12,1,2) THEN 'K��'
    WHEN MONTH(date) IN (3,4,5) THEN '�lkbahar'
    WHEN MONTH(date) IN (6,7,8) THEN 'Yaz'
    ELSE 'Sonbahar'
  END AS sezon,
  COUNT(*) AS toplam_satis
FROM groceries_dataset
GROUP BY
  CASE 
    WHEN MONTH(date) IN (12,1,2) THEN 'K��'
    WHEN MONTH(date) IN (3,4,5) THEN '�lkbahar'
    WHEN MONTH(date) IN (6,7,8) THEN 'Yaz'
    ELSE 'Sonbahar'
  END
ORDER BY toplam_satis DESC;
