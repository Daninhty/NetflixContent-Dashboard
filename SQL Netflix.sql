-- drop kolom null
alter table dbo.['Power Query$']
drop column F13, F14, F15

-- cek keseluruhan
select * from dbo.['Power Query 2$']

-- menghitung total konten
select 
	count(distinct show_id) as total_content 
from dbo.['Power Query 2$']

-- menghitung jumlah dan persentase tipe konten
select 
	type,
	count(distinct show_id) as total,
	round(
		count(distinct show_id) * 100 / 
		sum(count(distinct show_id)) over(), 2) as percentage
from dbo.['Power Query 2$']
group by type

-- menghitung jumlah genre konten
select
	genre_group,
	count (distinct show_id) as total_konten
from dbo.['Power Query 2$']
group by genre_group
order by total_konten desc

-- menghitung distribusi genre per tipe konten
select 
	type,
	genre_group,
	count(distinct show_id) as total_konten
from dbo.['Power Query 2$']
group by type, genre_group
order by type, total_konten desc

-- Top 10 direktor
select top 10
	director,
	count(distinct show_id) as total_konten
from dbo.['Power Query 2$']
where director is not null
	and director <> 'Tidak Tersedia'
group by director
order by total_konten desc

-- konten per tahun ditambahkan ke netflix
select 
	year(date_added) as year_added,
	count(distinct show_id) as total_konten
from dbo.['Power Query 2$']
where date_added is not null
group by year(date_added)
order by year_added

-- distribusi rating usia
select
	rating,
	count(distinct show_id) as total_konten
from dbo.['Power Query$']
where rating is not null
group by rating
order by total_konten desc

-- distribusi rilis negara
select
	country,
	count(distinct show_id) as total_rilis
from dbo.['Power Query 2$']
where country is not null
  and country <> 'Tidak Tersedia'
  and country <> ''
group by country
order by total_rilis desc