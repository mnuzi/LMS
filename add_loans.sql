-- Run once in Supabase SQL Editor. Adds the borrowing history table.
create table loans (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz default now(),
  book_id uuid not null references books(id) on delete cascade,
  member_id uuid not null references members(id) on delete cascade,
  borrowed_at timestamptz default now(),
  due_date date,
  returned_at timestamptz   -- empty = still borrowed
);
alter table loans enable row level security;
create policy "allow all loans" on loans for all using (true) with check (true);

-- history for the 3 books that are borrowed right now
insert into loans (book_id, member_id, borrowed_at, due_date)
select id, member_id, (due_date - 14)::timestamptz, due_date from books where member_id is not null;

-- dummy returned loans so the dashboard has data (title, member, days ago borrowed, days ago returned)
insert into loans (book_id, member_id, borrowed_at, due_date, returned_at)
select b.id, m.id, now() - (x.d || ' days')::interval, current_date - x.d + 14, now() - (x.r || ' days')::interval
from (values
  ('The Great Gatsby','Bilal Ahmed',9,6), ('The Great Gatsby','Fatima Noor',14,10), ('The Great Gatsby','Hira Siddiqui',20,16),
  ('1984','Zainab Hussain',25,21), ('1984','Omar Farooq',10,7),
  ('To Kill a Mockingbird','Usman Tariq',5,3), ('To Kill a Mockingbird','Hassan Ali',22,18),
  ('The Alchemist','Sara Malik',6,2), ('The Alchemist','Ayesha Khan',15,11),
  ('Atomic Habits','Ahmed Raza',8,5)
) as x(title, member, d, r)
join books b on b.title = x.title join members m on m.name = x.member;
