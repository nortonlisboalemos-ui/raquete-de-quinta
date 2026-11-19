-- Sorteio dos jogos do dia (Raquete de Quinta)
-- Rode uma vez no SQL Editor do Supabase.
create table if not exists sorteios (
  id uuid primary key default gen_random_uuid(),
  turma_id text references turmas(id) on delete cascade,
  data date not null,
  jogos jsonb not null,
  criado_por text,
  created_at timestamptz not null default now(),
  unique (turma_id, data)
);
alter table sorteios enable row level security;
drop policy if exists acesso_publico on sorteios;
create policy acesso_publico on sorteios for all to anon, authenticated using (true) with check (true);
grant select, insert, update, delete on sorteios to anon, authenticated;
