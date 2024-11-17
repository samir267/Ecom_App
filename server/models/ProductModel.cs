using server.Models;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

public class ProductModel
{
    [Key]
    public int Id { get; set; }

    [Required]
    [MaxLength(100)]
    public string Name { get; set; }

    [MaxLength(500)]
    public string Description { get; set; }

    [Required]
    public int Quantity { get; set; }

    [Required]
    public string Image { get; set; }  // Ajouté ici

    [Required]
    public decimal Price { get; set; }

    // Foreign key to Category
    [ForeignKey("Category")]
    public int CategoryId { get; set; }

    // Foreign key to User
    [ForeignKey("User")]
    public int UserId { get; set; }

    // Navigation property for reviews
    public ICollection<ReviewModel> Reviews { get; set; }
}
