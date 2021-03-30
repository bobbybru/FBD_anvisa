SELECT count(a.ls_pis_cofins) cred_tributario,
		c.nome
FROM anvisa.preco as a
inner join anvisa.laboratorio_has_medicamento as b
on a.Medicamento_produto=b.Medicamento_produto
inner join anvisa.laboratorio as c
on b.Laboratorio_cnpj=c.cnpj
group by c.nome
order by cred_tributario desc
 
