using CloudinaryDotNet.Actions;
using CloudinaryDotNet;
using Microsoft.AspNetCore.Mvc;
using server.Dto;  // Import ProductDto
using System.IO;
using server.Models;
using server.Services;

[ApiController]
[Route("api/[controller]")]
public class ProductController : ControllerBase
{
    private readonly Cloudinary _cloudinary;
    private readonly ProductService _productService;

    public ProductController(Cloudinary cloudinary, ProductService productService)
    {
        _cloudinary = cloudinary;
        _productService = productService;
    }

    // Ajouter un produit avec une image
    [HttpPost]
    [Consumes("multipart/form-data")]
    public async Task<IActionResult> AddProduct(
     [FromForm] string name,
     [FromForm] string description,
     [FromForm] int quantity,
     [FromForm] decimal price,
     [FromForm] int categoryId,
     [FromForm] int userId,
     [FromForm] IFormFile image)
    {
        if (image == null || image.Length == 0)
        {
            return BadRequest(new { message = "Aucune image n'a été envoyée." });
        }

        // Paramètres pour l'upload sur Cloudinary
        var uploadParams = new ImageUploadParams
        {
            File = new FileDescription(image.FileName, image.OpenReadStream()),
            UseFilename = true,
            UniqueFilename = true,
            Overwrite = false
        };

        // Upload de l'image sur Cloudinary
        var uploadResult = await _cloudinary.UploadAsync(uploadParams);

        if (uploadResult.StatusCode != System.Net.HttpStatusCode.OK)
        {
            return BadRequest(new { message = "L'upload de l'image a échoué.", details = uploadResult.Error?.Message });
        }

        // Crée le produit à partir des informations
        var productDto = new ProductDto
        {
            Name = name,
            Description = description,
            Quantity = quantity,
            Price = price,
            CategoryId = categoryId,
            UserId = userId,
            Image = uploadResult.SecureUrl.ToString()
        };

        // Ajouter le produit dans la base de données
        var createdProduct = await _productService.AddProductAsync(productDto);

        return CreatedAtAction(nameof(GetProductById), new { id = createdProduct.Id }, createdProduct);
    }

    // Récupérer un produit par son Id
    [HttpGet("{id}")]
    public async Task<ActionResult<ProductModel>> GetProductById(int id)
    {
        var product = await _productService.GetProductByIdAsync(id);
        return product == null ? NotFound() : Ok(product);
    }

    // Récupérer tous les produits
    [HttpGet]
    public async Task<ActionResult<IEnumerable<ProductModel>>> GetAllProducts()
    {
        var products = await _productService.GetAllProductsAsync();
        return Ok(products);
    }

    // Récupérer un produit avec ses avis
    [HttpGet("{id}/reviews")]
    public async Task<ActionResult<ProductModel>> GetProductWithReviews(int id)
    {
        var product = await _productService.GetProductWithReviewsAsync(id);
        return product == null ? NotFound() : Ok(product);
    }
}
