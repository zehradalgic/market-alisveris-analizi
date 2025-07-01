-- 1)Tablo genelinde toplam kayýt sayýsý ve her sütundaki dolu/boþ (NULL) deðerlerin sayýsý
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


-- 2) Her müþterinin yaptýðý alýþveriþlerde ortalama kaç ürün satýn aldýðý sorgusu
SELECT AVG(urun_sayisi) AS ortalama_urun_sayisi
FROM (
  SELECT member_number, COUNT(*) AS urun_sayisi
  FROM groceries_dataset
  GROUP BY member_number
) AS alt_sorgu;
go

-- 3) En çok satýlan ilk 10 ürünün listesi
SELECT TOP 10 itemdescription, COUNT(*) AS satis_adedi
FROM groceries_dataset
GROUP BY itemdescription
ORDER BY satis_adedi DESC;
go

-- 4) Ayný alýþveriþte en çok beraber satýn alýnan ürün çiftlerinin listesi (ilk 10)
SELECT TOP 10 g1.itemdescription AS urun1, g2.itemdescription AS urun2, COUNT(*) AS beraber_satis_sayisi
FROM groceries_dataset g1
JOIN groceries_dataset g2
  ON g1.member_number = g2.member_number AND g1.itemdescription < g2.itemdescription
GROUP BY g1.itemdescription, g2.itemdescription
ORDER BY beraber_satis_sayisi DESC;
go

--5)Belirli bir müþterinin (member_number = 4501) tüm alýþveriþ kayýtlarýný listeleme
select * from groceries_dataset where member_number=4501
go

--6) Yýllara ve aylara göre toplam satýþ sayýsýnýn daðýlýmý
SELECT YEAR(date) AS yil, MONTH(date) AS ay, COUNT(*) AS toplam_satis
FROM groceries_dataset
GROUP BY YEAR(date), MONTH(date)
ORDER BY yil, ay;
go

--7) Mevsimlere göre toplam satýþ sayýlarýnýn analizi
SELECT
  CASE 
    WHEN MONTH(date) IN (12,1,2) THEN 'Kýþ'
    WHEN MONTH(date) IN (3,4,5) THEN 'Ýlkbahar'
    WHEN MONTH(date) IN (6,7,8) THEN 'Yaz'
    ELSE 'Sonbahar'
  END AS sezon,
  COUNT(*) AS toplam_satis
FROM groceries_dataset
GROUP BY
  CASE 
    WHEN MONTH(date) IN (12,1,2) THEN 'Kýþ'
    WHEN MONTH(date) IN (3,4,5) THEN 'Ýlkbahar'
    WHEN MONTH(date) IN (6,7,8) THEN 'Yaz'
    ELSE 'Sonbahar'
  END
ORDER BY toplam_satis DESC;
