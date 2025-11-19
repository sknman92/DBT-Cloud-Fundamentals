-- for each diagnosis category finding percentage of cases where the health plan's decision was upheld/overturned

-- fetching wrangled data
with model as (
    select *
    from {{ ref('stg_ax__492') }}
),

-- finding determination status
status as (
    select "Diagnosis Category"
    , "Patient Gender"
    , "Age Range"
    , "Treatment Category"
    , CASE 
        WHEN "Determination" ilike '%Overturned%' THEN 'Overturned'
        WHEN "Determination" ilike '%Upheld%' THEN 'Upheld'
        ELSE null
    END as determination_status
    , 1 as count
    from model
),

-- finding status count
status_count as (
    select "Diagnosis Category"
    , SUM(CASE determination_status WHEN 'Overturned' THEN count else 0 end) as overturned_count
    , SUM(CASE determination_status WHEN 'Upheld' THEN count else 0 end) as upheld_count
    , sum(count) as total_count
    from status
    group by 1  
    order by 1
),

-- finding status percentage
task_1 as (
    select "Diagnosis Category"
    , round((overturned_count/total_count) * 100, 1) as perc_overturned
    , round((upheld_count/total_count) * 100, 1) as perc_upheld
    from status_count
    order by 1
), 

-- finding overturned per male and female
task_2a as (
    select "Patient Gender"
    , "Age Range"
    , sum(count) as overturned_count
    from status
    where "Patient Gender" is not null
    and determination_status = 'Overturned'
    group by 1, 2
),

task_2b as (
    select *
    , rank() over (partition by "Patient Gender" order by overturned_count desc) as count_rank
    from task_2a
),

task_2 as (
    select *
    from task_2b
    where count_rank = 1
),

-- finding number overturned per diagnosis and treatment category
task_3 as (
    select "Diagnosis Category"
    , "Treatment Category"
    , sum(count) as overturned_count
    from status
    where determination_status = 'Overturned'
    group by 1, 2
    order by 1, 2
)

select *
from task_3
