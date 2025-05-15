use ipl;
desc deliveries;
desc matches;
select count(match_id) from deliveries;
select count(id) from matches;
select * from deliveries;
select * from matches;
select player_of_match from matches where id = 1;
select count(id)
from matches
where city = "Delhi"  and toss_decision = "bat";
SELECT distinct city FROM matches;
select  distinct city from matches where city like ("%u%");
select  distinct city from matches where city like ("%u_");
select substr("Rising Pune Supergiants",8,4) City;
select replace("Rising Pune Supergiants","Pune","Andheri") City;
select avg(win_by_runs), max(win_by_runs), min(win_by_runs) from matches;
select * from matches where win_by_runs in (select max(win_by_runs) from matches);
select not null umpire3 from matches where umpire3 is not null;
select count(coalesce(umpire3))from matches;
select count(*)
from matches 
where win_by_runs = 14;
select (win_by_runs)
from matches 
where win_by_runs < 14;

select id, win_by_runs,
	case
		when avg(win_by_runs) > 14 then "won above avg"  
		when avg(win_by_runs) = 14 then "won by avg" 
		when avg(win_by_runs) < 14 then "won below avg" 
        else "tie"
        end as Result
        from matches;
        
select * from deliveries;
select * from matches;

select player_of_match, count(*) Awards from matches 
group by player_of_match
order by Awards desc limit 5;

select count(winner) Wins from matches
group by Wins;