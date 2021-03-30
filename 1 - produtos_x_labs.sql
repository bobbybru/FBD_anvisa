SELECT count(a.Medicamento_Registro_CD_GGEREM) as total_produto,
	b.nome
FROM anvisa.laboratorio_has_medicamento as a
left join anvisa.laboratorio as b
on b.cnpj=a.Laboratorio_cnpj
group by b.nome
order by total_produto desc