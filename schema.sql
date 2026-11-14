-- Run once in Supabase: SQL Editor > New query > paste > Run
create table members (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz default now(),
  name text not null,
  email text,
  phone text
);
create table books (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz default now(),
  title text not null,
  author text not null,
  isbn text,
  category text,
  member_id uuid references members(id),  -- empty = available, filled = borrowed by that member
  due_date date
);
alter table members enable row level security;
alter table books enable row level security;
create policy "allow all members" on members for all using (true) with check (true);
create policy "allow all books" on books for all using (true) with check (true);
