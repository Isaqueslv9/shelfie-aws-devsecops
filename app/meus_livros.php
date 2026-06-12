<?php
include 'templates/header.php';
require 'conexao.php';

// Configuração da Paginação
$limit = 8; // Livros por página
$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
$offset = ($page > 0) ? ($page - 1) * $limit : 0;

//Busca e Filtro
$params = [$_SESSION['id_usuario']];
$sql = "SELECT SQL_CALC_FOUND_ROWS * FROM livros WHERE id_usuario = ?";

if (!empty($_GET['busca'])) {
    $sql .= " AND (titulo LIKE ? OR autor LIKE ?)";
    $params[] = '%' . $_GET['busca'] . '%';
    $params[] = '%' . $_GET['busca'] . '%';
}
if (!empty($_GET['filtro_status'])) {
    $sql .= " AND andamento = ?";
    $params[] = $_GET['filtro_status'];
}

$sql .= " ORDER BY data_adicao DESC LIMIT ? OFFSET ?";
$params[] = $limit;
$params[] = $offset;
$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$livros = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Total de resultados para a paginação
$total_livros = $pdo->query("SELECT FOUND_ROWS()")->fetchColumn();
$total_pages = ceil($total_livros / $limit);
?>

<div class="container page-container">
    <h1>Meus Livros</h1>
    
    <div class="search-filter-box">
        <form action="meus_livros.php" method="GET">
             <input type="text" name="busca" placeholder="Buscar por título ou autor..." value="<?= htmlspecialchars($_GET['busca'] ?? '') ?>">
            <select name="filtro_status">
                <option value="">Todos</option>
                <option value="Lido" <?= ($_GET['filtro_status'] ?? '') == 'Lido' ? 'selected' : '' ?>>Lido</option>
                <option value="Lendo" <?= ($_GET['filtro_status'] ?? '') == 'Lendo' ? 'selected' : '' ?>>Lendo</option>
                <option value="Quero Ler" <?= ($_GET['filtro_status'] ?? '') == 'Quero Ler' ? 'selected' : '' ?>>Quero Ler</option>
                <option value="Abandonei" <?= ($_GET['filtro_status'] ?? '') == 'Abandonei' ? 'selected' : '' ?>>Abandonei</option>
            </select>
            <button type="submit">Filtrar</button>
        </form>
    </div>



<div class="livros-grid">
    <?php foreach ($livros as $livro): ?>
        <div class="livro-card">
            <div class="card-favorito">
                <a href="processa_favorito.php?id=<?= htmlspecialchars($livro['id']) ?>">
                    <i class="<?= $livro['favorito'] ? 'fa-solid fa-star' : 'fa-regular fa-star' ?>"></i>
                </a>
            </div>
            <h4><?= htmlspecialchars($livro['titulo']) ?></h4>
            <p><strong>Autor:</strong> <?= htmlspecialchars($livro['autor']) ?></p>

            <?php if (!empty($livro['editora'])): ?>
                <p><strong>Editora:</strong> <?= htmlspecialchars($livro['editora']) ?></p>
            <?php endif; ?>

            <span class="status-tag"><?= htmlspecialchars($livro['andamento']) ?></span>
            
            <div class="card-actions">
                <a href="editar_livro.php?id=<?= htmlspecialchars($livro['id']) ?>" class="btn-edit">Editar</a>
                
                <a href="processa_exclusao.php?id=<?= htmlspecialchars($livro['id']) ?>" class="btn-delete" onclick="return confirm('Tem certeza que deseja excluir este livro?')">Excluir</a>
            </div>
        </div>
    <?php endforeach; ?>
</div>



    <div class="pagination">
        <?php for ($i = 1; $i <= $total_pages; $i++): ?>
            <a href="?page=<?= htmlspecialchars($i) ?>&busca=<?= htmlspecialchars($_GET['busca'] ?? '') ?>&filtro_status=<?= htmlspecialchars($_GET['filtro_status'] ?? '') ?>" class="<?= $page == $i ? 'active' : '' ?>"><?= htmlspecialchars($i) ?></a>
        <?php endfor; ?>
    </div>
</div>

<?php include 'templates/footer.php'; ?>