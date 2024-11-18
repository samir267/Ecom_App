using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using server.Dto;
using server.Models;
using server.Services;
using CloudinaryDotNet;
using CloudinaryDotNet.Actions;
using dotenv.net;

namespace server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private readonly ProductService _productService;
        private readonly Cloudinary _cloudinary;

        public ProductController(ProductService productService)
        {
            _productService = productService;
            DotEnv.Load();

            var cloudinaryUrl = Environment.GetEnvironmentVariable("CLOUDINARY_URL");
            if (cloudinaryUrl == null)
            {
                throw new InvalidOperationException("CLOUDINARY_URL is not set in environment variables.");
            }

            _cloudinary = new Cloudinary(cloudinaryUrl);
        }

        // CREATE : Ajouter un produit
        [HttpPost]
        [HttpPost]
		[Consumes("multipart/form-data")]

		public async Task<IActionResult> AddProduct([FromForm] ProductModel product)
        {

			
			if (product.Imageform == null || product.Imageform.Length == 0)
			{
				return BadRequest(new { message = "Aucune image n'a été téléchargée." });
			}

			// Paramètres d'upload de l'image
			var uploadParams = new ImageUploadParams
            {
                File = new FileDescription(product.Imageform.FileName,product.Imageform.OpenReadStream()),
                UseFilename = true,
                UniqueFilename = false,
                Overwrite = true
            };


            // Tentative d'upload de l'image
            var uploadResult = await _cloudinary.UploadAsync(uploadParams);

            // Vérification si l'upload a échoué
            if (uploadResult.StatusCode != System.Net.HttpStatusCode.OK)
            {
                // Retourner une erreur si l'upload échoue
                return BadRequest(new { message = "L'upload de l'image a échoué.", details = uploadResult.Error?.Message });
            }

            // Si l'upload est réussi, mettre à jour l'URL de l'image du produit
            product.Image = uploadResult.SecureUrl.ToString();

            // Ajouter le produit dans la base de données
            var createdProduct = await _productService.AddProductAsync(product);

            // Retourner une réponse 201 avec le produit créé
            return CreatedAtAction(nameof(GetProductById), new { id = createdProduct.Id }, createdProduct);
        }


        // READ : Récupérer un produit par ID
        [HttpGet("{id}")]
        public async Task<IActionResult> GetProductById(int id)
        {
            var product = await _productService.GetProductByIdAsync(id);
            if (product == null)
            {
                return NotFound();
            }
            return Ok(product);
        }

        // READ : Récupérer tous les produits
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ProductModel>>> GetAllProducts()
        {
            var products = await _productService.GetAllProductsAsync();
            return Ok(products);
        }

        // UPDATE : Mettre à jour un produit
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateProduct(int id, [FromBody] UpdateProductDto product)
        {
            if (product == null)
            {
                return BadRequest();
            }

            var updatedProduct = await _productService.UpdateProductAsync(id, product);
            if (updatedProduct == null)
            {
                return NotFound();
            }
            return Ok(updatedProduct);
        }

        // DELETE : Supprimer un produit
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProduct(int id)
        {
            var result = await _productService.DeleteProductAsync(id);
            if (!result)
            {
                return NotFound();
            }
            return NoContent();
        }
    }
}
