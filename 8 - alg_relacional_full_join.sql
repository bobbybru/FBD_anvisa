select a.produto, 
	    b.pmc
from anvisa.medicamento as a
join anvisa.preco as b
ON Medicamento_principio_ativo = principio_ativo 
	AND Medicamento_apresentacao = apresentacao 
	AND Medicamento_produto = produto