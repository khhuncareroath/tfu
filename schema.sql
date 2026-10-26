-- Tech Founder University: run this ONCE in Supabase -> SQL Editor -> New query -> Run.
-- It is safe to run again if something went wrong (it replaces its own rules).

create table if not exists public.items (
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  id      text not null,
  updated bigint not null default 0,
  data    jsonb not null default '{}'::jsonb,
  primary key (user_id, id)
);

create table if not exists public.meta (
  user_id uuid primary key default auth.uid() references auth.users(id) on delete cascade,
  updated bigint not null default 0,
  data    jsonb not null default '{}'::jsonb
);

-- Row Level Security: each account can only see and change its own rows.
alter table public.items enable row level security;
alter table public.meta  enable row level security;

drop policy if exists "items own rows" on public.items;
create policy "items own rows" on public.items
  for all to authenticated
  using (user_id = auth.uid()) with check (user_id = auth.uid());

drop policy if exists "meta own row" on public.meta;
create policy "meta own row" on public.meta
  for all to authenticated
  using (user_id = auth.uid()) with check (user_id = auth.uid());

-- Private file bucket. Every file lives in a folder named after your user id.
insert into storage.buckets (id, name, public)
values ('files', 'files', false)
on conflict (id) do nothing;

drop policy if exists "files read own"   on storage.objects;
drop policy if exists "files insert own" on storage.objects;
drop policy if exists "files update own" on storage.objects;
drop policy if exists "files delete own" on storage.objects;

create policy "files read own" on storage.objects for select to authenticated
  using (bucket_id = 'files' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "files insert own" on storage.objects for insert to authenticated
  with check (bucket_id = 'files' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "files update own" on storage.objects for update to authenticated
  using (bucket_id = 'files' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "files delete own" on storage.objects for delete to authenticated
  using (bucket_id = 'files' and (storage.foldername(name))[1] = auth.uid()::text);
