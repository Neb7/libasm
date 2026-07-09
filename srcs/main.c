/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: benpicar <benpicar@student.42mulhouse.fr>  +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/07/08 17:39:09 by benpicar          #+#    #+#             */
/*   Updated: 2026/07/08 19:15:48 by benpicar         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "ft.h"

int	main(void)
{
	char	dest[30], *s1, buf;
	s1 = ft_strdup("Hello, World!");
	printf("Test ft_strlen : ft_strlen(\"Hello, World!\") = %lu\n",
			ft_strlen("Hello, World!"));
	printf("Test ft_strcpy : ft_strcpy(dest, \"Hello, World!\") = %s\n",
			ft_strcpy(dest, "Hello, World!"));
	printf("Test ft_strcmp : ft_strcmp(\"Hello\", \"HellO\") = %d\n",
			ft_strcmp("Hello", "HellO"));
	printf("\nTest ft_write : ft_write(1, \"Hello, World!\", 13) = %zd\n",
		    ft_write(1, "Hello, World!", 13));
	printf("Test ft_strdup : ft_strdup(\"Hello, World!\") = %s\n", s1);
	printf("Test ft_read : %d\n", 'o' - 'O');
	while (ft_read(0, &buf, 1) > 0)
		printf("%c", buf);
	return (0);
}