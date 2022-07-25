create table author (
  id uuid references auth.users not null,
  updated_at timestamp with time zone default (now() at time zone 'utc'),
  created_at timestamp with time zone default (now() at time zone 'utc'),
  name text,
  age integer,
  primary key (id),
  constraint author_name_length check (char_length(name) >= 3)
);

create table book (
  id serial not null,
  updated_at timestamp with time zone,
  created_at timestamp with time zone,
  name text,
  genre text,
  author_id uuid references author(id) not null,
  primary key (id),
  constraint book_name_length check (char_length(name) >= 3)
);

alter table author enable row level security;
alter table book enable row level security;

-- author table policy
create policy "Enable read access for all users"
  on author for select
  to anon, authenticated
  using (true );

create policy "Enable insert for authenticated users only" 
  on author for insert
  to authenticated
  with check (auth.uid()=id);

create policy "Enable update for users based on id" 
  on author for update
  to authenticated
  using (auth.uid() = id)
  with check (auth.uid()=id);

create policy "Enable delete for users based on user_id" 
  on author for delete
  to authenticated
  using (auth.uid() = id);

-- book table policy
create policy "Enable read access for all users"
  on book for select
  to anon, authenticated
  using (true );

create policy "Enable insert for authenticated users only" 
  on book for insert
  to authenticated
  with check (auth.uid() = author_id);

create policy "Enable update for users based on id" 
  on book for update
  to authenticated
  using (auth.uid() = author_id)
  with check (auth.uid()= author_id);

create policy "Enable delete for users based on user_id" 
  on book for delete
  to authenticated
  using (auth.uid() = author_id);


-- Set up Realtime
begin;
  drop publication if exists supabase_realtime;
  create publication supabase_realtime;
commit;
alter publication supabase_realtime add table author;
alter publication supabase_realtime add table book;