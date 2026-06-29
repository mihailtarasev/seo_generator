final class SiteConfig {
  const SiteConfig({
    required this.siteUrl,
    required this.defaultLocale,
    required this.locales,
  });

  final String siteUrl;
  final String defaultLocale;
  final List<String> locales;
}